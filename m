Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311712AbSCZRYj>; Tue, 26 Mar 2002 12:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312588AbSCZRYU>; Tue, 26 Mar 2002 12:24:20 -0500
Received: from air-2.osdl.org ([65.201.151.6]:3456 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S311712AbSCZRYO>;
	Tue, 26 Mar 2002 12:24:14 -0500
Date: Tue, 26 Mar 2002 09:24:07 -0800
From: Bob Miller <rem@osdl.org>
To: Frederik Nosi <fredi@e-salute.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile problem in 2.5.7
Message-ID: <20020326092407.A1797@doc.pdx.osdl.net>
In-Reply-To: <200203261518.g2QFI9B09441@smtp2.flashnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 03:12:48PM +0100, Frederik Nosi wrote:
> I am trying to compile 2.5.7 kernel but something goes wrong.
> Here are the results of make bzImage:
> 
> make: *** [vmlinux] Error 1
> arch/i386/kernel/kernel.o: In function `sys_call_table':
> arch/i386/kernel/kernel.o(.data+0x300): undefined reference to 
> `sys_nfsservctl' make: *** [vmlinux] Error 1
> 
> Here is my configuration too:
> 
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_ISA=y
> # CONFIG_SBUS is not set
> CONFIG_UID16=y
> 

Stuff deleted...

> Please CC me for more info as I'm not subscribed in the lkml.
> 
> fredi
> -

Look at:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=101664690520722&w=2

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
