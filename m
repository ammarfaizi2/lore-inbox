Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264513AbSIVUJf>; Sun, 22 Sep 2002 16:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264515AbSIVUJf>; Sun, 22 Sep 2002 16:09:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57606 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264513AbSIVUJe>; Sun, 22 Sep 2002 16:09:34 -0400
Date: Sun, 22 Sep 2002 16:07:26 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: A few thoughts on contest
Message-ID: <Pine.LNX.3.96.1020922155637.7956A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago I sent Con a set of results run on a 1GB RAM machine and
rerun on decreasing memory using mem=. The problem I noted was in the
io_half test, which runs totally in memory on a large memory machine. I
would encourage people running the test to take this into account. I now
run all my tests in no more than 256M, although runs with smaller memory
give information on which kernel might be better in those cases.

I also patched my io_XXX scripts to check the residual size of the file
and the loop count and to report the bytes transferred, seconds, and
transfer rate. This is sometimes quite different for kernels which are
otherwise very similar.

Hope this is useful to people.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

