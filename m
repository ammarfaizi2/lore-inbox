Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWA3RPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWA3RPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWA3RPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:15:08 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:7068 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S964793AbWA3RPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:15:06 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 Jan 2006 18:14:02 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <43DE495A.nail2BR211K0O@burner>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner>
 <20060129112613.GA29356@merlin.emma.line.org>
 <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr>
 <43DD2A8A.nailGVQ115GOP@burner>
 <787b0d920601291328k52191977h3778a7c833d640f2@mail.gmail.com>
 <43DE3A99.nail16ZK1MAWN@burner>
 <787b0d920601300831j99fae82n5d4a5d94f99baafd@mail.gmail.com>
 <43DE405D.nail2AM2BPF20@burner>
 <20060130170813.GG19173@merlin.emma.line.org>
In-Reply-To: <20060130170813.GG19173@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> > > > > struct stat sbuf;
> > > > > stat("/dev/hdc", &sbuf);
> > > > > int bus = sbuf.st_mode>>12;
> > > > > int target = major(sbuf.st_rdev);
> > > > > int lun = minor(sbuf.st_rdev);
> > > >
> > > > Now tell me how to match this with information from /dev/sg*
> > >
> > > You do the obvious, scanning /dev to find the device file.
> > 
> > I am sorry, but you obviously did not understand the problem.
>
> Stop offending people who are trying to be helpful just because they
> suggest different solutions than you expect. You - again - elided
> Albert's crucial part, which even included an offer to fix things:

I am sorry to see your recent dicussion style.

I was asking a question and I did get a completely useless answer as
any person who has some basic know how Linux SCSI would know that
doing a stat("/dev/sg*", ...) will not return anything useful.

If people give useful answers, it makes sense to continue a discussion but it 
turns out that "joe average" on KLML replies before thinking about the problem. 

Let me ask again:

	Is there a way to get (or construct) a closed view on the namespace 
	for all SCSI devices?


And IMPORTANT: don't answer unless you have a real answer for the problem.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
