Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWBJLoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWBJLoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWBJLoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:44:15 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:44954 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1750997AbWBJLoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:44:14 -0500
Date: Fri, 10 Feb 2006 12:45:05 +0100
From: DervishD <lkml@dervishd.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, matthias.andree@gmx.de, lsorense@csclub.uwaterloo.ca,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210114505.GB2750@DervishD>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	peter.read@gmail.com, matthias.andree@gmx.de,
	lsorense@csclub.uwaterloo.ca, linux-kernel@vger.kernel.org,
	jim@why.dont.jablowme.net
References: <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208210219.GB9166@DervishD> <20060208211455.GC2480@csclub.uwaterloo.ca> <43EB1988.nail7EL2I7AN6@burner> <20060209145740.GB94@DervishD> <43EB62CA.nailCFH31KKTA@burner> <20060209173351.GA432@DervishD> <43EC7199.nailISD1164I0@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43EC7199.nailISD1164I0@burner>
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
> DervishD <lkml@dervishd.net> wrote:
> >  * Joerg Schilling <schilling@fokus.fraunhofer.de> dixit:
> > > >     Could you please clarify which things are broken by Matthias
> > > > patch? This way he (or other developer) can prepare a better patch
> > > > and maintain it. BTW, I patched my cdrecord with Matthias patch and
> > > > nothing seems to be broken :? Maybe am I missing something?
> > > 
> > > It is completely broken and thus makes no sense at all.
> >
> >     OK, I understand now... Completely broken... Have you any actual
> > proof or should I use my faith and just believe it is completely
> > broken?
> 
> What is your intent for writing this?

    My intention is to get real proofs about the "brokenness" of the
patch, not just an "It is completely broken". That's not technical.
That's the same than saying "Windows sucks". Now, tell why it sucks,
in technical terms.

    A better example: it is like saying that the numbering scheme
that cdrecord uses is crap. That's nontechnical. A technical approach
is "UNIX userspace programs doesn't use three numbers to talk to
devices, they use /dev nodes, so cdrecord is breaking the UNIX way of
doing things". Or "Windows uses letters to refer to storage devices
and cdrecorders and not three numbers, so cdrecord is breaking the
way of doing things on Windows". I don't even ask for a deep
technical discussion, anything more technical than "It is completely
broken" will do.
 
> FUD?

    Why do you think that? Have I offended you? Have I attacked
you personally? Up to this point I have:

    - Asked for technical reasons about a patch rejection.
    - Tell my *opinion*, as a cdrecord user, about the user
interface.

    I can't see fear, my only uncertainty is about the technical
(un)correctness of the patch, which you haven't clarified yet, and my
only doubt is if there are programs, apart from cdrecord and libscg
users, which uses your numbering scheme instead of /dev entries :?
That makes (at worst) UD, but not FUD.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
