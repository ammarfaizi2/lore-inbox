Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbSJYR0L>; Fri, 25 Oct 2002 13:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbSJYR0K>; Fri, 25 Oct 2002 13:26:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14345 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261504AbSJYR0H>; Fri, 25 Oct 2002 13:26:07 -0400
Date: Fri, 25 Oct 2002 13:31:41 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
In-Reply-To: <2832683854.1035444175@[10.10.2.3]>
Message-ID: <Pine.LNX.3.96.1021025133002.19333A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Martin J. Bligh wrote:

> > Another thought, how does this play with NUMA systems? I don't have the
> > problem, but presumably there are implications.
> 
> At some point we'll probably only want one shared set per node.
> Gets tricky when you migrate processes across nodes though - will
> need more thought

The whole issue of pages shared between nodes is a graduate thesis waiting
to happen.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

