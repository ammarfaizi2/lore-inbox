Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131544AbRCXCIv>; Fri, 23 Mar 2001 21:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131557AbRCXCIl>; Fri, 23 Mar 2001 21:08:41 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:24476 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S131544AbRCXCI1>; Fri, 23 Mar 2001 21:08:27 -0500
Date: Sat, 24 Mar 2001 02:08:17 +0000 (GMT)
From: Paul Jakma <paul@jakma.org>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: Paul Jakma <paulj@itg.ie>, <linux-mm@kvack.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.30.0103232312440.13864-100000@fs131-224.f-secure.com>
Message-ID: <Pine.LNX.4.33.0103240203340.11627-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001, Szabolcs Szakacsits wrote:

> Nonsense hodgepodge. See and/or mesaure the impact. I sent numbers in my
> former email. You also missed non-overcommit must be _optional_ [i.e.
> you wouldn't be forced to use it ;)]. Yes, there are users and
> enterprises who require it and would happily pay the 50-100% extra swap
> space for the same workload and extra reliability.

ok.. the last time OOM came up, the main objection to fully
guaranteed vm was the possible huge overhead.

if someone knows how to do it without a huge overhead, i'd love to
see it and try it out.

> At every time you add/delete users, add/delete special apps, etc.

no.. pam_limits knows about groups, and you can specify limit for
that group, one time.

@user ... ... ...

> Rik's killer is quite fine at _default_. But there will be always
> people who won't like it

exactly... so lets try avoid ever needing it. it is a last resort.

> default, use the /proc/sys/vm/oom_killer interface"? As I said
> before there are also such patch by Chris Swiedler and definitely
> not a huge, complex one.

uhmm.. where?

> And these stupid threads could be forgotten for good and all.

:)

> 	Szaka

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
The optimum committee has no members.
		-- Norman Augustine

