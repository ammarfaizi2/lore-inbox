Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289299AbSBNB0L>; Wed, 13 Feb 2002 20:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289313AbSBNB0D>; Wed, 13 Feb 2002 20:26:03 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:49169
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S289299AbSBNBZ5>; Wed, 13 Feb 2002 20:25:57 -0500
Date: Thu, 14 Feb 2002 02:25:48 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH SIS_IDE] Fix for v0.13 chipset detection code
Message-ID: <20020214022548.B16320@bouton.inet6-interne.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the 0.13 sis5513.c version had bad detection data. Latest patch corrects
this (at least on my SiS735 based system).
I've not yet get ridden of the SiSHostChipInfo[] dependancy, this will
be v0.14 material.

If you have a SiS chipset that is not from the ATA66 generation, you
probably have a need for this version, please test.

http://inet6.dyn.dhs.org/sponsoring/sis5513/sis.patch.20020214_1
or (mirror, learned its need the hard way)
http://gyver.homeip.net/sis5513/sis.patch.20020214_1

This is against stock 2.4.17, must apply cleanly to 2.4.18preX/rc1 and
should apply to several earlier 2.4.x.

Additional info on:

http://inet6.dyn.dhs.org/sponsoring/sis5513/index.html

Happy (U)DMA'ing.

LB.
