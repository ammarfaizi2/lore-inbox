Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWBHVB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWBHVB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWBHVB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:01:28 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:16828 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1751130AbWBHVB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:01:28 -0500
Date: Wed, 8 Feb 2006 22:02:19 +0100
From: DervishD <lkml@dervishd.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jim@why.dont.jablowme.net, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060208210219.GB9166@DervishD>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jim@why.dont.jablowme.net, peter.read@gmail.com,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <200602021717.08100.luke@dashjr.org> <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr> <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43E9F1CD.nail2BR11FL52@burner>
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
> > The people replying here are your users, if you don't want to listen to
> > them pretty much any conversation with you will be a waste of time.
> 
> Sorry, but from reading the mail from _real_ cdrecord users, it is
> obvious that the people here are either not my users or users with
> a stange way of thinking.

    Joerg, I know you're going to ignore this email just as you
ignored other emails I sent you in the past regarding cdrecord, the
annoying numbering scheme and the stupid "your DMA speed is too slow,
you cannot write at more than 12x" (fortunately, my CD writer doesn't
know that and writes correctly at 50x and even more). Anyway, I want
to tell you that I've been a cdrecord _real_ user for more than 5
years, and while I consider your work valuable and clever, you have
NO respect for anybody who doesn't think the same as you. I know many
cdrecord users (_real_ ones, IMHO), and ALL of them think that the
numbering scheme to access their writers is CRAP: crappy design,
crappy coding and crappy user interface.

    I'm going to be a bit more respectful: I don't consider it crap.
I just consider it bad. Bad because cdrecord is the only program in
my system that forces me to think what the heck is the correct number
for my CD writer (which is /dev/cdrw in my system) or which number do
I have to use to READ a CD image using "readcd" (instead of /dev/cdrw
or /dev/dvd, or even the ugly /dev/hdc). I end up using "-scanbus"
everytime I use a system which is not mine, and that's bad, because
most of those systems have /dev/cdrw, or /dev/cdrecorder, or
something like that.

    Joerg, the problem is that you never listen to things you don't
like. I understand, because I sometimes do exactly the same, but I
don't maintain a program with thousand of users...

    cdrecord is GPL, so in the end nobody has the right to ask you to
modify it in ways you don't like or you don't want it to. That goes
with free software: you don't pay, you don't have the right to ask
for things. But, how about trying to listen to third parties? I mean,
you are probably OK ignoring my suggestions, I am probably a mediocre
programmer, but... do you _really_ think that you are more clever
than ALL the programmers in this mailing list? Do you _really_ think
that you have the correct answer and that ALL of them are plainly
wrong? Do you _REALLY_ think that EVERYBODY is wrong *except* you in
this issue about the user interface?

    C'mon, Joerg, you're more clever than that. You probably know
that a program where half the options have a leading "-" and the
other half doesn't have it probably has a bad user interface. You
know that if a program uses a naming convention different from ALL
the rest of programs is because the program has a problem. You know
that if the only UNIX program out there that doesn't use /dev entries
to talk to devices is cdrecord, the problem *probably* is in
cdrecord, and not in UNIX...

    Well, I will stop here. I don't want to argue with you about this
because I'm not sure if I'm right or not. I just happen to like more
the "/dev" approach that a set of three numbers to locate a unit in a
SCSI bus that I DON'T HAVE in my box...

    Believe me: I consider you a very good programmer and a very
clever person, but your attitude is...

    My best wishes, Joerg.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
