Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269223AbTCBOlT>; Sun, 2 Mar 2003 09:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269224AbTCBOlT>; Sun, 2 Mar 2003 09:41:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56836 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269223AbTCBOlT>;
	Sun, 2 Mar 2003 09:41:19 -0500
Date: Sun, 2 Mar 2003 14:51:43 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.63: Hang on reboot
Message-ID: <20030302145143.GA745@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 14:49:03 up 3 min,  1 user,  load average: 0.04, 0.11, 0.05
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  2.5.63 on Tyan S2460 motherboard (Dual Athlon MP, 760 chipset), discs on
both the internal controller and a promise TX100.

  If I'm in 2.4.18 and tell it to reboot, the BIOS does its stuff and
I land in grub and I can tell it to boot into 2.5.63 etc.

  If I'm in 2.5.63 and tell it to reboot, the BIOS seems to do all its
stuff, the Promise BIOS runs, and it gets to the point just before
GRUB would normally appear and then stops.

  I guess this is either the BIOS being unhappy or 2.5.63 leaving
some of the hardware in an unhappy state.

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
