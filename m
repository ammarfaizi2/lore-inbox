Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266781AbRGTI4f>; Fri, 20 Jul 2001 04:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266788AbRGTI4Z>; Fri, 20 Jul 2001 04:56:25 -0400
Received: from weta.f00f.org ([203.167.249.89]:11653 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266781AbRGTI4K>;
	Fri, 20 Jul 2001 04:56:10 -0400
Date: Fri, 20 Jul 2001 20:56:25 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Matthew Gardiner <kiwiunix@ihug.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Warning: indirect lcall without `*'
Message-ID: <20010720205625.A20247@weta.f00f.org>
In-Reply-To: <01072016295800.27056@kiwiunix.ihug.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01072016295800.27056@kiwiunix.ihug.co.nz>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Its a warning from gas, you safely can ignore this.




  --cw

On Fri, Jul 20, 2001 at 04:29:58PM +1200, Matthew Gardiner wrote:
    gcc -D__KERNEL__ -I/usr/src/linux-2.4.6/include -Wall -Wstrict-prototypes 
    -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
    -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o apm.o apm.c
    {standard input}: Assembler messages:
    {standard input}:188: Warning: indirect lcall without `*'
    {standard input}:265: Warning: indirect lcall without `*'
    make[1]: Leaving directory `/usr/src/linux-2.4.6/arch/i386/kernel'
    make -C  arch/i386/mm CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.6/include 
    -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
    -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
    -march=i686 -DMODULE" MAKING_MODULES=1 modules
    make[1]: Entering directory `/usr/src/linux-2.4.6/arch/i386/mm'
    make[1]: Nothing to be done for `modules'.
    make[1]: Leaving directory `/usr/src/linux-2.4.6/arch/i386/mm'
    make -C  arch/i386/lib CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.6/include 
    -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
    -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
    -march=i686 -DMODULE" MAKING_MODULES=1 modules
    make[1]: Entering directory `/usr/src/linux-2.4.6/arch/i386/lib'
    make[1]: Nothing to be done for `modules'.
    make[1]: Leaving directory `/usr/src/linux-2.4.6/arch/i386/lib'
    [root@kiwiunix linux]#
    -- 
    WARNING:
    
    This email was written on an OS using the viral 'GPL' as its license.
    
    Please check with Bill Gates before continuing to read this email/posting.
    -
    To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html
    Please read the FAQ at  http://www.tux.org/lkml/
