Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263047AbSJBLcm>; Wed, 2 Oct 2002 07:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263052AbSJBLcm>; Wed, 2 Oct 2002 07:32:42 -0400
Received: from fep02.tuttopmi.it ([212.131.248.101]:19678 "EHLO
	fep02-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S263047AbSJBLcl> convert rfc822-to-8bit; Wed, 2 Oct 2002 07:32:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Frederik Nosi <fredi@e-salute.it>
Reply-To: fredi@e-salute.it
To: linux-kernel@vger.kernel.org
Subject: 2.4.xx/2.5.40 neofb notes
Date: Wed, 2 Oct 2002 13:48:10 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210021348.10867.fredi@e-salute.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old DELL Latitude CPi233D laptop with this Neomagic card (from 
/proc/pci):
   
 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] 
(rev 1).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=255.
      Prefetchable 32 bit memory at 0xf1000000 [0xf1ffffff].
      Non-prefetchable 32 bit memory at 0xfde00000 [0xfdffffff].
      Non-prefetchable 32 bit memory at 0xfdd00000 [0xfddfffff].

With 2.4.(18|19|20-preX) with the neofb driver, scrolling up in 
vim/less/man/ecc (in console, not in X) is dog slow, somthing like a 2/3 
lines in second. Scrolling down is fast.

The 2.5 kernel that I've tryed are 2.5.39 & 2.5.40.
With 2.5.39 the slowlyness issue has desapeared an everything works fine.

With 2.5.40 the only difference from 2.5.39 is that when shutting down the 
system, i get an oops from the nmfb driver, with more or less this message:

Danger danger! Oopsen imminent
MTRR setting reg 2

I tried compiling with & without preempt, with ACPI, with APM (after disabling 
ACPI) with the same results.

Sory for my poor english

Cheers,
Frederik Nosi
