Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWBGShp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWBGShp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWBGShp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:37:45 -0500
Received: from atpro.com ([12.161.0.3]:52240 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S964855AbWBGSho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:37:44 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Tue, 7 Feb 2006 13:37:12 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, peter.read@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060207183712.GC5341@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	matthias.andree@gmx.de, peter.read@gmail.com,
	linux-kernel@vger.kernel.org
References: <20060123105634.GA17439@merlin.emma.line.org> <200602021717.08100.luke@dashjr.org> <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr> <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43E89B56.nailA792EWNLG@burner>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/06 02:06:30PM +0100, Joerg Schilling wrote:
> "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> 
> > You're not alone, I'm still waiting for an answer as to why cdrecord is
> > the only userland app on any OS to use his SCSI ID naming convention
> > and yet his is the correct way. I've asked twice and been blatantly
> > ignored both times.
> 
> Well, while I did explain this many times (*), I am still waiting 
> for an explanation why Linux tries to deviate from nearly all other OS.
> 
> *) in case you like are on amnesia: without the mapping in libscg,
> cdrecord could not be used reliably on Linux. And yes, I _do_ care
> about people who run Linux-2.4 or older!
> 
> 
> It seems that we should stop this discussion.
> 
> As long as the peeople who answer here are onlookers without the 
> needed skills, it seems to be a waste of time.
> 
> Jörg

All you've explained is that using SCSI ID for device names is the way
you want cdrecord to work, not why it's infinitely better than using real
device names like every other userland program on every OS in existance.

And please name a case where 'cdrecord dev=/dev/cdrom file.iso' won't work
reliably because I, and it would seem many others, haven't run into it.
there was the case where recording audio doesn't do DMA, but that's a bug
in ide-scsi and I AFAIK it doesn't matter whether you use dev=/scd0 or
dev=1,0,0 to address the drive.  And also, I believe dev=/dev/scd0 will
work with ide-scsi in 2.4, but I don't have a machine to test that on.

The people replying here are your users, if you don't want to listen to
them pretty much any conversation with you will be a waste of time.

Jim.
