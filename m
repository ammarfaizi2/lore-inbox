Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBOU0k>; Thu, 15 Feb 2001 15:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBOU0a>; Thu, 15 Feb 2001 15:26:30 -0500
Received: from pilsener.srv.ualberta.ca ([129.128.5.19]:64647 "EHLO
	pilsener.srv.ualberta.ca") by vger.kernel.org with ESMTP
	id <S129066AbRBOU0T>; Thu, 15 Feb 2001 15:26:19 -0500
Date: Thu, 15 Feb 2001 13:26:17 -0700 (MST)
From: Anthony Fok <foka@ualberta.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kajtar Zsolt <soci@singular.sch.bme.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1ac13/14 problem
In-Reply-To: <E14TUs4-0000la-00@the-village.bc.nu>
Message-ID: <Pine.A41.4.10.10102151322330.19842-100000@gpu2.srv.ualberta.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001, Alan Cox wrote:
> > Calibrating delay loop... 466.94 BogoMIPS
> > Memory: 62836k/65536k available (712k kernel code, 2312k reserved, 188k
> > data, 56k init, 0k highmem)
> > Checking if this processor honours the WP bit even in supervisor mode...
> > 
> > Here it freezes forever... My cpu:
> > 
> > vendor_id	: CyrixInstead
> 
> Ok I've been trying to fix the Cyrix/cpuid problems and it appears I
> may have overdone it. I'll reread the code in detail.
> 
> Alan

Hello Alan,

For your information, 2.4.1-ac12 works great on my Cyrix 6x86 P166+, and
it properly recognizes the CPU as i586 class.

I haven't tried 2.4.1-ac13 on that machine yet, but I did attempt to boot
2.4.1-ac13 on an Winchip-C6 machine.  It froze at the same place, i.e.
"Checking if this processor honours the WP bit even in supervisor
mode...".  2.4.1-ac12 works quite nicely on this machine, although I still
experience random crashes on this machine.  (Don't know if it is the
kernel or hardware problem... I have been having troubles with this
computer with just about any kernels since 2.2.17...)  One of these days,
when I have time, I'll post the Oops or the Bug.

Meanwhile, 2.4.x is rock solid on my Cyrix machine.  :-)

Thanks,

Anthony

-- 
Anthony Fok Tung-Ling                Civil and Environmental Engineering
foka@ualberta.ca, foka@debian.org    University of Alberta, Canada
   Debian GNU/Linux Chinese Project -- http://www.debian.org/intl/zh/
Come visit Our Lady of Victory Camp -- http://www.olvc.ab.ca/

