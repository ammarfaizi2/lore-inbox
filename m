Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSGVPRj>; Mon, 22 Jul 2002 11:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSGVPRj>; Mon, 22 Jul 2002 11:17:39 -0400
Received: from dsl-213-023-038-020.arcor-ip.net ([213.23.38.20]:14255 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316840AbSGVPRi>;
	Mon, 22 Jul 2002 11:17:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Guillaume Boissiere <boissiere@adiglobal.com>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Date: Mon, 22 Jul 2002 17:22:13 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <3D361091.13618.16DC46FB@localhost> <20020722102342.GE1196@fib011235813.fsnet.co.uk>
In-Reply-To: <20020722102342.GE1196@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Wf0s-0001tS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 July 2002 12:23, Joe Thornber wrote:
> It would be good if other volume managers embrace device-mapper
> allowing us to work together on the kernel side, and compete in
> userland.  Kernel development takes *far* too much manpower for us to
> be duplicating work.

Competition has its own benefits.

> For example I released the LVM2 vs EVMS snapshot
> benchmarks in the hope of encouraging EVMS to move over to
> device-mapper, unfortunately 2 months later a reply is posted stating
> that they have now developed equivalent (but broken) code :(

Supposing both device-mapper and (the kernel part of) EVMS get into the tree, 
there's nothing stopping you from submitting a patch to make EVMS use 
device-mapper.  If there's already equivalent code in EVMS, that just makes 
the job easier.

I'm firmly in the 'we need both' camp.

EVMS is a full-bloated^W blown enterprise solution, ready to go with every
imaginable bell and whistle.  Device-mapper represents the classic Linux 
minimalist approach.  Hopefully, with the two side-by-side in the tree, both 
will evolve more rapidly.

-- 
Daniel
