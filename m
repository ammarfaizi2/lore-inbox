Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWBJLs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWBJLs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWBJLs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:48:29 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:47827 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1750998AbWBJLs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:48:28 -0500
Date: Fri, 10 Feb 2006 12:49:30 +0100
From: DervishD <lkml@dervishd.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210114930.GC2750@DervishD>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mj@ucw.cz, peter.read@gmail.com, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
	jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43EC71FB.nailISD31LRCB@burner>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Joerg :)

 * Joerg Schilling <schilling@fokus.fraunhofer.de> dixit:
> Martin Mares <mj@ucw.cz> wrote:
> > > This is why the mapping engine is in the Linux adoption part of
> > > libscg. It maps the non-stable device <-> /dev/sg* relation to a
> > > stable b,t,l address.
> >
> > Nonsense. The b,t,l addresses are NOT stable (at least for transports
> 
> Dou you like to verify that you have no clue on SCSI?

    My system is clueless, too! If I write a CD before plugging my
USB storage device, my CD writer is on 0,0,0. If I plug my USB
storage device *before* doing any access, my cdwriter is on 1,0,0.
Pretty stable.

    But of course, I could made all of the above stable by using
udev. But then the /dev/sg mapping will be stable, too. I can't see
why the three random numbers are more stable than /dev/sg. By the
way, I don't have any SCSI host adapter in my system.

    And please, Joerg, be more respectful when answering. It doesn't
cost money and people will likely respect you, too.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
