Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129146AbRB1SXq>; Wed, 28 Feb 2001 13:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbRB1SXg>; Wed, 28 Feb 2001 13:23:36 -0500
Received: from mail.surgient.com ([63.118.236.3]:15113 "EHLO
	bignorse.SURGIENT.COM") by vger.kernel.org with ESMTP
	id <S129146AbRB1SXc>; Wed, 28 Feb 2001 13:23:32 -0500
Message-ID: <A490B2C9C629944E85CE1F394138AF957FC3EB@bignorse.SURGIENT.COM>
From: "Collins, Tom" <Tom.Collins@Surgient.com>
To: "'Lee Ho'" <i@flyduck.com>, linux-kernel@vger.kernel.org
Cc: "Collins, Tom" <Tom.Collins@Surgient.com>
Subject: RE: Multiple file module build problems
Date: Wed, 28 Feb 2001 12:23:20 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="KS_C_5601-1987"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I tried ld -r -o scharmod.o schar.o procschar.o
and it still seems to be trying to build an exectuable...the
output is the same as before...

Thanks

Tom
-----Original Message-----
From: Lee Ho [mailto:i@flyduck.com]
Sent: Wednesday, February 28, 2001 12:00 PM
To: linux-kernel@vger.kernel.org
Cc: Collins, Tom
Subject: Re: Multiple file module build problems



It seems that linker tried to build executable file.
When building multiple module source into one module object file,
ld with '-r' option is used. 

ld -r -o scharmod.o schar.o procschar.o 

*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
Lee, Ho. Software Engineer, Embedded Linux Dep, LinuxOne 
Mail : flyduck@linuxone.co.kr (work), i@flyduck.com (personal)
Homepage : http://flyduck.com, http://linuxkernel.to

    Collins, Tom Wrote:
    
    
    I am trying to build a multiple-file kernel module, and am
    having some difficulty.  It seems that the linker is trying
    to build and executable.
    
    The link command is:
    
    ld -m elf_i386 -o scharmod.o schar.o procschar.o
    

