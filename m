Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSD2Vuu>; Mon, 29 Apr 2002 17:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315209AbSD2Vut>; Mon, 29 Apr 2002 17:50:49 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62477 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315207AbSD2Vus>; Mon, 29 Apr 2002 17:50:48 -0400
Date: Mon, 29 Apr 2002 17:46:28 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Mike Fedyk <mfedyk@matchmail.com>, Stephen Samuel <samuel@bcgreen.com>,
        linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
In-Reply-To: <Pine.LNX.4.10.10204260028140.10216-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.96.1020429173812.26335B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002, Andre Hedrick wrote:

> 
> Basically it is a global design flaw from the beginning, and since I have
> only 2.4 to address it is a real nasty!  Short version, each subdriver
> personally does not do unique error handling.

  I'm snipping because obviously lots of folks are reading the previous
posts. Since you clearly can see the issue, I will let this thread rest in
hopes that we will have a patch to try and that it will make the whole
problem shrink if not vanish.

  It seems the casual assumption that anyone who has a problem must be
putting both devices on the same cable has been laid to rest, time to wait
for new data and/or patches. I will try again next weekend to test the
same problem using a totally separate (Promise) controller for the CD.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

