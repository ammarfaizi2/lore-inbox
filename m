Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131286AbRCWRGT>; Fri, 23 Mar 2001 12:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131290AbRCWRGL>; Fri, 23 Mar 2001 12:06:11 -0500
Received: from dentin.eaze.net ([216.228.128.151]:25092 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S131286AbRCWRF3>;
	Fri, 23 Mar 2001 12:05:29 -0500
Date: Fri, 23 Mar 2001 11:00:27 -0600 (CST)
From: SodaPop <soda@xirr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gOAz-0004MB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103231053020.27155-100000@xirr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik, is there any way we could get a /proc entry for this, so that one
could do something like:

cat /proc/oom-kill-scores | sort +3

to get a process list (similar to ps) with a field for the current oom
scores?  It would likely be very useful to be able to dump the current
scores and see what will be the first thing to die, and may help people
tune the killer for specific uses.

Part of the current problem with the OOM killer is that people only know
what it's going to kill after it's too late.

-dennis T


