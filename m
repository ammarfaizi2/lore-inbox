Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSLGSdI>; Sat, 7 Dec 2002 13:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSLGSdH>; Sat, 7 Dec 2002 13:33:07 -0500
Received: from web20409.mail.yahoo.com ([66.163.169.97]:16188 "HELO
	web20421.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264653AbSLGSdB>; Sat, 7 Dec 2002 13:33:01 -0500
Message-ID: <20021207184038.34687.qmail@web20421.mail.yahoo.com>
Date: Sat, 7 Dec 2002 10:40:38 -0800 (PST)
From: Z F <mail4me9999@yahoo.com>
Subject: RE: CPU cache problem
To: Manish Lachwani <manish@Zambeel.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
       linux-kernel@vger.kernel.org
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1AD7@xch-a.win.zambeel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Manish and Mark

The BIOS does not have any info about L2 cache accept for
enable/disable
switch.
I noticed that after the POST message in the table of all installed
devices it said CPU 1.7 GHz... Memory installed 256 M (RAM) and 
CPU cache: NONE.

I have upgraded the BIOS on the system and now it says 128K, as it
should, according to CPU specifications.
Mark tells that /proc/cpuinfo reports L1 cache size (which I assume is 
8K+12 K in my case, even though I do not understand what that means)
But how to check that L2 is operational?

For windows I have ASUSprobe software, which after the BIOS upgrade
started to report that CPU has L2 cache, but it reports it regardless
of BIOS switch(enable/disable) as if program simply reads the CPU
specifications. (Before BIOS upgrade it reported 0K L2 cache.)

The question I have is: Is it possible to tell whether or not
the kernel sees the L2 CPU cache and its size?

Thank you very much for your help

Lazar


--- Manish Lachwani <manish@Zambeel.com> wrote:
> Did you check in the BIOS if there is an L2 cache size mentioned? Not
> every
> BIOS supports it but you shoud check there ...
> 
> Thanks
> -Manish
> 
> -----Original Message-----
> From: Z F [mailto:mail4me9999@yahoo.com]
> Sent: Friday, December 06, 2002 8:32 PM
> To: linux-kernel@vger.kernel.org
> Subject: CPU cache problem
> 
> 
> Hello everybody
> 
> Sorry to bother you with such a question, but I have a 
> Intel 1.7GHz Celeron processor with ASUS P4S533 motherboard.
> The problem I have is that cat /proc/cpuinfo reports that
> 
> cache size      : 20 KB
> 
> As far as I know, the CPU has 128K L2 cache.
> 
> The kernel version installed on my computer is 2.4.18.
> I tried using cachesize=128 as a boot parameter, but it did not help.
> L2 cache is enabled in BIOS.
> 
> Could someone tell me why it is happening, how to fix it and should I
> be
> worried that the motherboard is defective.
> 
> Thank you very much for your kind help
> 
> Lazar
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
