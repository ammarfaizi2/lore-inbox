Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285574AbRLRFni>; Tue, 18 Dec 2001 00:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285585AbRLRFn3>; Tue, 18 Dec 2001 00:43:29 -0500
Received: from [206.40.202.198] ([206.40.202.198]:48730 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S285574AbRLRFnK>; Tue, 18 Dec 2001 00:43:10 -0500
Date: Mon, 17 Dec 2001 21:41:02 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Thierry Forveille <forveill@cfht.hawaii.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <15390.53230.827019.336771@hoku.cfht.hawaii.edu>
Message-ID: <Pine.LNX.3.95.1011217213742.581a-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Thierry Forveille wrote:

> Date: Mon, 17 Dec 2001 19:11:10 -1000 (HST)
> From: Thierry Forveille <forveill@cfht.hawaii.edu>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Scheduler ( was: Just a second ) ...
> 
> Linus Torvalds (torvalds@transmeta.com) writes
> > On Mon, 17 Dec 2001, Rik van Riel wrote:
> > >
> > > Try readprofile some day, chances are schedule() is pretty
> > > near the top of the list.
> >
> > Ehh.. Of course I do readprofile.
> >  
> > But did you ever compare readprofile output to _total_ cycles spent?
> >
> I have a feeling that this discussion got sidetracked: cpu cycles burnt 
> in the scheduler indeed is non-issue, but big tasks being needlessly moved
> around on SMPs is worth tackling.

Given a cpu affinity facility, policy mgmt would belong in user space.
CPU affinity would be pretty simple and I think the effort is already
in flight IIRC.

Johnh

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

