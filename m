Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137054AbREKGKb>; Fri, 11 May 2001 02:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137055AbREKGKV>; Fri, 11 May 2001 02:10:21 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:28301 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S137054AbREKGKN>; Fri, 11 May 2001 02:10:13 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105110610.IAA04590@sunrise.pg.gda.pl>
Subject: Re: make menuconfig versus make xconfig, Kernel 2.4
To: backes@rhrk.uni-kl.de
Date: Fri, 11 May 2001 08:10:00 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (LINUX Kernel)
In-Reply-To: <XFMail.20010511075040.backes@rhrk.uni-kl.de> from "Joachim Backes" at May 11, 2001 07:50:40 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joachim Backes wrote:"
> I made an update from Kernel 2.2.19 to 2.4.4, and I made
> a copy from the 2.2.19 .config file into the 2.4.4 directory.
> 
> After that, I was wondering about the following fact:
> 
> "make menuconfig" for kernel 2.4.4 showed (what seems to
> be correct) for ATA/IDE the same kernel configuration, as it
> was shown in 2.2.19, when using the 2.2.19 ".config".
> 
> But: 2.4.4 "make xconfig" using the 2.2.19 .config showed
> a disabled ATA/IDE configuration.
> 
> Only after saving the 2.4.4 configuration produced by "make menuconfig",
> then the configuration for ATA/IDE was correctly displayed by "make xconfig".


The Menuconfig behaviour is probably incorrect. CONFIG_IDE is missing.
Try
    make oldconfig 
first.
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
