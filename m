Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbTAXAB7>; Thu, 23 Jan 2003 19:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267477AbTAXAB7>; Thu, 23 Jan 2003 19:01:59 -0500
Received: from [209.184.141.189] ([209.184.141.189]:8261 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S267474AbTAXAB6>;
	Thu, 23 Jan 2003 19:01:58 -0500
Subject: Using O(1) scheduler with 600 processes.
From: Austin Gonyou <austin@coremetrics.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Coremetrics, Inc.
Message-Id: <1043367029.28748.130.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 23 Jan 2003 18:10:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've heard some say that O(1) sched can only really help on systems with
lots and lots of processes.

But my systems run about 600 processes max, but are P4 Xeons with HT,
and we kick off several hundred processes sometimes. (sleeping to
running then back) based on things happening in the system. 

I am possibly going to forgo putting O(1)sched in production *right now*
until I've got my patch solid. But I got to thinking, do I need it at
all on a Oracle VLDB?

I think yes, but I wanted to get some opinions/facts before making that
choice to go without O(1) sched.


-- 
Austin Gonyou <austin@coremetrics.com>
Coremetrics, Inc.
