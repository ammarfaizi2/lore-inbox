Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262114AbSJDUTH>; Fri, 4 Oct 2002 16:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbSJDUTA>; Fri, 4 Oct 2002 16:19:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18585 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262030AbSJDURr>;
	Fri, 4 Oct 2002 16:17:47 -0400
Date: Fri, 4 Oct 2002 13:22:31 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <mbligh@aracnet.com>
Subject: Re: [PATCH] patch-slab-split-03-tail
In-Reply-To: <3D9DE8E1.6030105@colorfullife.com>
Message-ID: <Pine.LNX.4.33L2.0210041321370.20655-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, Manfred Spraul wrote:

| Andrew Morton wrote:
| >
| > Makes sense.  It would be nice to get this confirmed in
| > targetted testing ;)
|  >
| Not yet done.
|
| The right way to test it would be to collect data in kernel about
| alloc/free, and then run that data against both versions, and check
| which version gives less internal fragmentation.
|
| Or perhaps Bonwick has done that for his slab paper, but I don't have it :-(

Did you look at http://www.usenix.org/events/usenix01/bonwick.html
for it?

| * An implementation of the Slab Allocator as described in outline in;
| *      UNIX Internals: The New Frontiers by Uresh Vahalia
| *      Pub: Prentice Hall      ISBN 0-13-101908-2
| * or with a little more detail in;
| *      The Slab Allocator: An Object-Caching Kernel Memory Allocator
| *      Jeff Bonwick (Sun Microsystems).
| *      Presented at: USENIX Summer 1994 Technical Conference
| --

-- 
~Randy

