Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVLTVxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVLTVxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVLTVxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:53:16 -0500
Received: from graphe.net ([209.204.138.32]:59528 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932114AbVLTVxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:53:16 -0500
Date: Tue, 20 Dec 2005 13:52:52 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Steven Rostedt <rostedt@goodmis.org>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
In-Reply-To: <1135114971.13138.396.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0512201346550.20807@graphe.net>
References: <dnu8ku$ie4$1@sea.gmane.org>  <1134790400.13138.160.camel@localhost.localdomain>
  <1134860251.13138.193.camel@localhost.localdomain>  <20051220133230.GC24408@elte.hu>
  <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>  <20051220135725.GA29392@elte.hu>
  <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> 
 <1135093460.13138.302.camel@localhost.localdomain>  <20051220181921.GF3356@waste.org>
  <1135106124.13138.339.camel@localhost.localdomain> 
 <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
 <1135114971.13138.396.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Steven Rostedt wrote:

> What other interest have you pulled up on this?  I mean, have others
> shown interest in pushing something like this.  Today's slab system is
> starting to become like the IDE where nobody, but a select few
> sado-masochis, dare to venture in. (I've CC'd them ;)  Perhaps it would
> make the addition of NUMA easier.

Hmm. The basics of the SLAB allocator are rather simple. 

I'd be interested in seeing an alternate approach. There is the danger
that you will end up end up with the same complexity as before.

> http://marc.theaimsgroup.com/?l=linux-kernel&m=113510997009883&w=2

Quite a long list of unsupported features. These academic papers
usually only focus on one thing. The SLAB allocator has to work
for a variety of situations though.

It would help to explain what ultimately will be better in the new slab 
allocator. The complexity could be taken care of by reorganizing the code.

