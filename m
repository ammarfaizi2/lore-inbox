Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265384AbSKAJni>; Fri, 1 Nov 2002 04:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265419AbSKAJni>; Fri, 1 Nov 2002 04:43:38 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:60676 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S265384AbSKAJng> convert rfc822-to-8bit;
	Fri, 1 Nov 2002 04:43:36 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5] missing Config-help
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Fri, 01 Nov 2002 11:24:46 +0100
Message-ID: <87lm4dvb81.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running my 2.4 .config with 2.5.45 "make oldconfig" and miss the
following help texts:

,----
|     Generic PCI IDE Chipset Support (BLK_DEV_GENERIC) [N/y] (NEW) ?
| 
| Sorry, no help available for this option yet.
| 
|   nVidia NFORCE support (BLK_DEV_NFORCE) [N/m/y] (NEW) ?
| 
| Sorry, no help available for this option yet.
| 
|   PROMISE PDC202{46|62|65|67} support (BLK_DEV_PDC202XX_OLD) [N/m/y]
|   (NEW) ?
| 
| Sorry, no help available for this option yet.
| 
|   PROMISE PDC202{68|69|70|71|75|76|77} support (BLK_DEV_PDC202XX_NEW)
|   [N/m/y] (NEW) ?
| 
| Sorry, no help available for this option yet.
| 
|   Silicon Image chipset support (BLK_DEV_SIIMAGE) [N/m/y] (NEW) ?
| 
| Sorry, no help available for this option yet.
| 
|   Adaptec AIC7xxx support [Y/n/m] (NEW) ?
| 
| Sorry, no help available for this option yet.
| 
|   Adaptec AIC7xxx support (New driver, Old driver) [New driver] (NEW)
|   ?
| 
| Sorry, no help available for this option yet.
| 
|   DSCP match support (IP_NF_MATCH_DSCP) [N/m] (NEW) ?
| 
| Sorry, no help available for this option yet.
| 
|     Formula-n enter:now PCI card (EXPERIMENTAL) (HISAX_ENTERNOW_PCI)
|     [N/y] (NEW) ?
| 
| Sorry, no help available for this option yet.
| 
|     HFC PCI support (EXPERIMENTAL) (HISAX_HFCPCI) [N/m] (NEW) ?
| 
| Sorry, no help available for this option yet.
| 
| AMD 8151 support (AGP_AMD_8151) [N/y] (NEW) ?
| 
| Sorry, no help available for this option yet.
`----



And last a misleading help or broken config option.  The help talks
about "say Y", but that is not possible.  Hm.

,----
|   Helper match support (IP_NF_MATCH_HELPER) [N/m/?] (NEW) ?
| 
| Helper matching allows you to match packets in dynamic connections
| tracked by a conntrack-helper, ie. ip_conntrack_ftp
| 
| If you want to compile it as a module, say M here and read
| Documentation/modules.txt.  If unsure, say `Y'.
| 
|   Helper match support (IP_NF_MATCH_HELPER) [N/m/?] (NEW) y
| 
| Helper matching allows you to match packets in dynamic connections
| tracked by a conntrack-helper, ie. ip_conntrack_ftp
| 
| If you want to compile it as a module, say M here and read
| Documentation/modules.txt.  If unsure, say `Y'.
| 
|     Sequencer support (SND_SEQUENCER) [N/m/?] (NEW) ?
| 
| Say 'Y' or 'M' to enable MIDI sequencer and router support. This
| feature allows routing and enqueing MIDI events. Events can be
| processed at given time.
`----

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
