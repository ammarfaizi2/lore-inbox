Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273282AbSISVTK>; Thu, 19 Sep 2002 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273545AbSISVTI>; Thu, 19 Sep 2002 17:19:08 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64017 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S273541AbSISVS4>; Thu, 19 Sep 2002 17:18:56 -0400
Date: Thu, 19 Sep 2002 17:16:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Patrick Mansfield <patmans@us.ibm.com>
cc: Brian Waite <waite@skycomputers.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] [PATCH] 0/7 2.5.35 SCSI multi-path
In-Reply-To: <20020918090802.B14245@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.3.96.1020919171118.24603A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Patrick Mansfield wrote:

> Devices without serial numbers are treated as if they had different serial
> numbers, they show up as if there was no multi-path support.

That doesn't solve the problem, does it? If you have two devices w/o
serial they could look like one with multipath, with the change you note
that is prevented by making a single multipath device w/o serial look like
two. I have visions of programs using /dev/st0 and /dev/st1, having used
backup programs which grabbed every drive with a tape ready.

It is indeed a messy problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

