Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267451AbTAXAPS>; Thu, 23 Jan 2003 19:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbTAXAPS>; Thu, 23 Jan 2003 19:15:18 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64142 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267451AbTAXAPR>; Thu, 23 Jan 2003 19:15:17 -0500
Date: Thu, 23 Jan 2003 16:24:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
Subject: Re: Using O(1) scheduler with 600 processes.
Message-ID: <310350000.1043367864@titus>
In-Reply-To: <1043367029.28748.130.camel@UberGeek>
References: <1043367029.28748.130.camel@UberGeek>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've heard some say that O(1) sched can only really help on systems with
> lots and lots of processes.
> 
> But my systems run about 600 processes max, but are P4 Xeons with HT,
> and we kick off several hundred processes sometimes. (sleeping to
> running then back) based on things happening in the system. 
> 
> I am possibly going to forgo putting O(1)sched in production *right now*
> until I've got my patch solid. But I got to thinking, do I need it at
> all on a Oracle VLDB?
> 
> I think yes, but I wanted to get some opinions/facts before making that
> choice to go without O(1) sched.

How many *processors*? Real ones.

M.

