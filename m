Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbTABPNV>; Thu, 2 Jan 2003 10:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbTABPNU>; Thu, 2 Jan 2003 10:13:20 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:4367 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262040AbTABPNU>; Thu, 2 Jan 2003 10:13:20 -0500
Date: Thu, 2 Jan 2003 16:21:36 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Power off a SMP Box
Message-ID: <20030102152136.GA20193@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030102135350.24315441.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102135350.24315441.gigerstyle@gmx.ch>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Giger <gigerstyle@gmx.ch>
Date: Thu, Jan 02, 2003 at 01:53:50PM +0100
> Hi All,
> 
> I know this question was already asked 1000 times.
> 
> My "problem" is that my Dual-Box won't power off itself after a shutdown.
> 
> I tried with 
> 
> apm=smp-power-off	//no effect
> apm=power-off		//this one oopses on boot
> 
> I google'd around many hours with no solution.
> 
> Has someone a hint for me?
> 
Both my Abit VP6 and now a MSI Pro266TD Master work with:

kernel /boot/vmlinuz-2553matrox root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdc=scsi apm=smp apm=power-off

HTH,
Jurriaan
-- 
An ill wind comes arising
Across the cities of the plain
There's no swimming in the heavy water
No singing in the acid rain
   Rush - Distant Early Warning
GNU/Linux 2.5.53 SMP/ReiserFS 2x2752 bogomips load av: 0.02 0.18 0.09
