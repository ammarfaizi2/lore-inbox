Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281211AbRKEQ3j>; Mon, 5 Nov 2001 11:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281214AbRKEQ33>; Mon, 5 Nov 2001 11:29:29 -0500
Received: from ev6.be.wanadoo.com ([195.74.212.41]:23812 "EHLO
	ev6.be.wanadoo.com") by vger.kernel.org with ESMTP
	id <S281211AbRKEQ3T>; Mon, 5 Nov 2001 11:29:19 -0500
Message-ID: <3BE6BF22.E06E8D19@altern.org>
Date: Mon, 05 Nov 2001 17:32:34 +0100
From: SpaceWalker <spacewalker@altern.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart Young <sgy@amc.com.au>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <5.1.0.14.0.20011105144855.01f83310@mail.amc.localnet> <5.1.0.14.0.20011105154947.01f6fec0@mail.amc.localnet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Young wrote:
> 
> At 11:05 PM 4/11/01 -0500, Alexander Viro wrote:
> 
> >On Mon, 5 Nov 2001, Stuart Young wrote:
> >
> > > Any reason we can't move all the process info into something like
> > > /proc/pid/* instead of in the root /proc tree?
> >
> >Thanks, but no thanks.  If we are starting to move stuff around, we
> >would be much better off leaving in /proc only what it was supposed
> >to contain - per-process information.
> 

We could add a file into /proc like /proc/processes that contains once
all process informations that some programs like top or ps can read only
Once.
It could save a lot of time in kernel mode scanning the process list for
each process.
later, a new version of ps or top could simply stat /proc/processes and
if it exists uses it to give informations to the user.
What do you think of this idea ?


SpaceWalker

spacewalker@altern.org
ICQ 36157579
