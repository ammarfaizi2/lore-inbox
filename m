Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWBCRYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWBCRYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWBCRYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:24:49 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:25216 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751265AbWBCRYs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:24:48 -0500
From: Luke-Jr <luke@dashjr.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: Rationale for RLIMIT_MEMLOCK?)
Date: Fri, 3 Feb 2006 17:24:52 +0000
User-Agent: KMail/1.9
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
References: <20060123105634.GA17439@merlin.emma.line.org> <200602021717.08100.luke@dashjr.org> <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602031724.55729.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 February 2006 14:08, Jan Engelhardt wrote:
> >> >2. find out the current state of affairs,
> >>
> >> I am currently able to properly write all sorts of CD-R/RW and DVD±R/RW,
> >> DVD-DL with no problems using
> >>     cdrecord -dev=/dev/hdb
> >> it _currently_ works, no matter how ugly or not this is from either
> >> Jörg's or any other developer's POV - therefore it's fine from the
> >> end-user's POV.
> >
> >How did you manage to burn a dual layer disc? I have been completely
> >unsuccessful at doing this at all. :(
>
> You have to add  -driver=mmc_dvdplusr , because the Dual Layer discs are
> not yet in the ProDVD database as it seems.

ProDVD is immoral software. I use growisofs.

> >> I'm fine (=I agree) with the general possibility of having it setuid,
> >> though.
> >
> >Provided it doesn't allow burning files the real-user shouldn't be able to
> >access... But since cdrecord is commonly suid-root, I presume this has
> > long been taken into consideration.
>
> Security-critical environments like data centers

I'm not referring to anything security-critical, but basic minimal UNIX file 
permissions. If I have a file that's go-r, I expect that Joe Random User 
can't burn a CD/DVD with that file.
