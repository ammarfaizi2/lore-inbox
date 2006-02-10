Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWBJMOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWBJMOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWBJMOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:14:37 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:23507 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1751144AbWBJMOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:14:36 -0500
Date: Fri, 10 Feb 2006 13:15:41 +0100
From: DervishD <lkml@dervishd.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210121541.GA2804@DervishD>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mj@ucw.cz, linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
	jengelh@linux01.gwdg.de
References: <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD> <20060210115542.GA22337@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060210115542.GA22337@merlin.emma.line.org>
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

    Hi Matthias :)

 * Matthias Andree <matthias.andree@gmx.de> dixit:
> > > > Nonsense. The b,t,l addresses are NOT stable (at least for transports
> > > 
> > > Dou you like to verify that you have no clue on SCSI?
> > 
> >     My system is clueless, too! If I write a CD before plugging my
> > USB storage device, my CD writer is on 0,0,0. If I plug my USB
> > storage device *before* doing any access, my cdwriter is on 1,0,0.
> > Pretty stable.
> 
> Thanks for answering the question I directed towards Jörg, which proves
> Martin Mares's point that b,t,l is not stable.

    This is a typical problem with the BTL numbering that any 2.4.x
modular Linux kernel running without hotplug or udev has. And, at
least to my knowledge and in /dev/sg side, it can be fixed using
hotplug or udev (in 2.6.x). The BTL problem cannot.
 
> I think, Martin, too deserves Jörg's apology

    I think so. Martin was being very respectuf.

> and Jörg shouldn't only be more respectful, but listen to those who
> know their system better than he does. (Of course this'll turn into
> a flame feast how stupid Linux is.)

    And that's a pity, because it is a waste of human resources. And
the bigger problem is that I still don't know why BTL is better than
/dev/sg, and I've tried to understand it from the thread. I would be
glad to hear Jörg explanations, but he thinks I'm trying to FUD :(

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
