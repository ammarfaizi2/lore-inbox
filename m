Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTEKNAE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTEKM7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:59:42 -0400
Received: from mx0.gmx.net ([213.165.64.100]:7342 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S261364AbTEKM7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:59:09 -0400
Date: Sun, 11 May 2003 15:11:45 +0200 (MEST)
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <1052650249.6431.5.camel@LNX.iNES.RO>
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0007628267@gmx.net
X-Authenticated-IP: [217.224.154.184]
Message-ID: <353.1052658705@www4.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2003-05-11 at 00:13, Tuncer M zayamut Ayaz wrote:
> 
> > well, I actually saw PCMCIA functioning properly after
> > make clean'ing, recompiling and rebooting.
> > so no worries about that. now, off to find a replacement
> > for "APM idle calls".
> 
> You can try cpufreqd (to set the cpu according to the usage).
> http://sourceforge.net/projects/cpufreqd
> 
> I also use acpi performance states...
> 
> For instance on my laptop (Toshiba Satellite Pro 6100 , 2Ghz)
> I have this on /proc/acpi/processor/CPU0/performance :
> 
> [cioby@LNX cioby]$ cat /proc/acpi/processor/CPU0/performance
> state count:             2
> active state:            P0
> states:
>    *P0:                  2000 MHz, 22000 mW, 250 uS
>     P1:                  1200 MHz, 9800 mW, 250 uS
> 
> I often switch to performance state 1 even in if not running on battery.
> If I keep it in my lap, and do an kernel compile, I don't want my balls
> to get fryed :)

exactly why I need it too except that I don't put it on my lap but my
hands burn anyway. I hope not every laptop gets as hot as this one does.

do you
remember
http://www.google.de/search?q=cache:qGf0kfmazVgC:www.smh.com.au/articles/2002/11/22/1037697857595.html+&hl=de&ie=UTF-8
?

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte lächeln! Fotogalerie online mit GMX ohne eigene Homepage!

