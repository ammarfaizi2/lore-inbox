Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311648AbSCTPgD>; Wed, 20 Mar 2002 10:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311664AbSCTPfx>; Wed, 20 Mar 2002 10:35:53 -0500
Received: from [207.196.96.3] ([207.196.96.3]:54705 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S311648AbSCTPfs>; Wed, 20 Mar 2002 10:35:48 -0500
Date: Wed, 20 Mar 2002 10:52:47 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.7 fails compile on sched.c:1456
Message-ID: <Pine.LNX.4.40.0203201048390.7618-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw a patch went into the 2.5.7-pre series that was supposed control the
compilation of the preempt code, maybe its not quite right yet.

Building in my dual Alpha with SMP enabled fails with this:

sched.c: In function `init_idle':
sched.c:1456: structure has no member named `preempt_count'

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

