Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbSITQQK>; Fri, 20 Sep 2002 12:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262829AbSITQQK>; Fri, 20 Sep 2002 12:16:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12563 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262802AbSITQQJ>; Fri, 20 Sep 2002 12:16:09 -0400
Date: Fri, 20 Sep 2002 12:14:01 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Config thoughts
Message-ID: <Pine.LNX.3.96.1020920120902.29335A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having done a 2.5.36 config recently from scratch, I have a few thoughts
on the organization.

1 - why is clock in GMT part of APM?
2 - why aren't all the SCSI drivers in the low level drivers section in
some more intuitive grouping?
3 - same thing for NICs.

I have the impression that there is a lot of work being done in this area,
and there may be limitations of the dependencies causing this. If this
isn't all about to change I would love to do some reorg. I just don't want
to do something not useful.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

