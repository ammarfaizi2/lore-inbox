Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTAXGJe>; Fri, 24 Jan 2003 01:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267558AbTAXGJe>; Fri, 24 Jan 2003 01:09:34 -0500
Received: from franka.aracnet.com ([216.99.193.44]:25817 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267548AbTAXGJd>; Fri, 24 Jan 2003 01:09:33 -0500
Date: Thu, 23 Jan 2003 22:18:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: GrandMasterLee <masterlee@digitalroadkill.net>
cc: Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
Subject: Re: Using O(1) scheduler with 600 processes.
Message-ID: <435060000.1043389112@titus>
In-Reply-To: <1043388556.12894.23.camel@localhost>
References: <1043367029.28748.130.camel@UberGeek> <310350000.1043367864@titus> <1043388556.12894.23.camel@localhost>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I've heard some say that O(1) sched can only really help on systems with
>> > lots and lots of processes.
>> > 
>> > But my systems run about 600 processes max, but are P4 Xeons with HT,
>> > and we kick off several hundred processes sometimes. (sleeping to
>> > running then back) based on things happening in the system. 
>> > 
>> > I am possibly going to forgo putting O(1)sched in production *right now*
>> > until I've got my patch solid. But I got to thinking, do I need it at
>> > all on a Oracle VLDB?
>> > 
>> > I think yes, but I wanted to get some opinions/facts before making that
>> > choice to go without O(1) sched.
>> 
>> How many *processors*? Real ones.
> 
> Quad P4 Xeon. Dell 6650

I'd say you definitely want O(1) sched then (or just run -aa or something).
But why don't you just try it and see?

M.


