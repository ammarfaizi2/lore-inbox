Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264776AbSJVRJq>; Tue, 22 Oct 2002 13:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264777AbSJVRJq>; Tue, 22 Oct 2002 13:09:46 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51910 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S264776AbSJVRJp>; Tue, 22 Oct 2002 13:09:45 -0400
Date: Tue, 22 Oct 2002 15:15:29 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrew Morton <akpm@digeo.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
In-Reply-To: <3DB5865B.4462537F@digeo.com>
Message-ID: <Pine.LNX.4.44L.0210221514430.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Andrew Morton wrote:
> Rik van Riel wrote:
> >
> > ...
> > In short, we really really want shared page tables.
>
> Or large pages.  I confess to being a little perplexed as to
> why we're pursuing both.

I guess that's due to two things.

1) shared pagetables can speed up fork()+exec() somewhat

2) if we have two options that fix the Oracle problem,
   there's a better chance of getting at least one of
   the two merged ;)

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

