Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbTAXGBw>; Fri, 24 Jan 2003 01:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbTAXGBw>; Fri, 24 Jan 2003 01:01:52 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:58286
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267550AbTAXGBv>; Fri, 24 Jan 2003 01:01:51 -0500
Subject: Re: Using O(1) scheduler with 600 processes.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
In-Reply-To: <310350000.1043367864@titus>
References: <1043367029.28748.130.camel@UberGeek>
	 <310350000.1043367864@titus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1043388556.12894.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 00:09:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-23 at 18:24, Martin J. Bligh wrote:
> > I've heard some say that O(1) sched can only really help on systems with
> > lots and lots of processes.
> > 
> > But my systems run about 600 processes max, but are P4 Xeons with HT,
> > and we kick off several hundred processes sometimes. (sleeping to
> > running then back) based on things happening in the system. 
> > 
> > I am possibly going to forgo putting O(1)sched in production *right now*
> > until I've got my patch solid. But I got to thinking, do I need it at
> > all on a Oracle VLDB?
> > 
> > I think yes, but I wanted to get some opinions/facts before making that
> > choice to go without O(1) sched.
> 
> How many *processors*? Real ones.
> 
> M.
> 

Quad P4 Xeon. Dell 6650
