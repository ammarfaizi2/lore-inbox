Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWBIJCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWBIJCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWBIJCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:02:12 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:54174 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S965224AbWBIJCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:02:10 -0500
Date: Thu, 9 Feb 2006 10:02:59 +0100
From: DervishD <lkml@dervishd.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, jim@why.dont.jablowme.net,
       peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060209090259.GC93@DervishD>
Mail-Followup-To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jim@why.dont.jablowme.net, peter.read@gmail.com,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208210219.GB9166@DervishD> <20060208211455.GC2480@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060208211455.GC2480@csclub.uwaterloo.ca>
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

    Hi Lennart :)

 * Lennart Sorensen <lsorense@csclub.uwaterloo.ca> dixit:
> On Wed, Feb 08, 2006 at 10:02:19PM +0100, DervishD wrote:
> >     cdrecord is GPL, so in the end nobody has the right to ask you to
> > modify it in ways you don't like or you don't want it to. That goes
> > with free software: you don't pay, you don't have the right to ask
> > for things. But, how about trying to listen to third parties? I mean,
> > you are probably OK ignoring my suggestions, I am probably a mediocre
> > programmer, but... do you _really_ think that you are more clever
> > than ALL the programmers in this mailing list? Do you _really_ think
> > that you have the correct answer and that ALL of them are plainly
> > wrong? Do you _REALLY_ think that EVERYBODY is wrong *except* you in
> > this issue about the user interface?
> 
> Hmm, perhaps what should be done is that someone needs to write and
> maintain a patch that linux users can apply to cdrecord (since other OSs
> are different and hence have no reason to use such a patch), to make it
> behave in a manner which is sane on linux.  It should of course be
> clearly marked as having been changed in such a way.  It should use udev
> if available and HAL and whatever else is appropriate on a modern linux
> system, and if on an old system it should at least not break the
> interfaces that already worked on those systems in cdrecord.

    Matthias Andree posted such a patch last week, and he was ignored
by Joerg. In fact, he got an answer of "I haven't looked at it and I
never will" or something like that (check the list archives).

    Joerg was offered help to maintain a bit of code he doesn't want
to maintain and rejected it.
 
> cdrecord does a wonderful job writing CDs, once you get the silly
> command line syntax right and figure out which device option it
> wants you to tell it to access your write.  I still find the syntax
> of driveropts=option=value is a bit odd, although the linux kernel
> does the same thing for some kernel boot arguments as far as I
> recall, so who am I to argue.

    cdrecord is a good tool, no doubt about that. IMHO it can be
improved by changing the user interface and getting rid of useless
warnings, but nonetheless it is a good tool. The problem is Joerg
attitude...
 
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
