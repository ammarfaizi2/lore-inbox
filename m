Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310438AbSCXRAG>; Sun, 24 Mar 2002 12:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310470AbSCXQ74>; Sun, 24 Mar 2002 11:59:56 -0500
Received: from mustard.heime.net ([194.234.65.222]:41625 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S310438AbSCXQ7w>; Sun, 24 Mar 2002 11:59:52 -0500
Date: Sun, 24 Mar 2002 17:59:38 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: andreas <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <E16pBJE-0006hU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0203241757520.30437-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Alan Cox wrote:

> > I've got a basic question:
> > Would it be possible to kill only the process which consumes the most
> > memory in the last delta t?
> > Or does somebody have a better idea?
>
> At the point you hit OOM every possible heuristic is simply handwaving that
> will work for a subset of the user base. Fix the real problem and it goes
> away. My box doesn't OOM, the worst case (which I've never seen happen) is
> a task being killed by a stack growth failing to get memory.

Would it hard to do some memory allocation statistics, so if some process
at one point (as rsync did) goes crazy eating all memory, that would be
detected?

I'm quite sure other OSes have similar funcitonality, such as AIX

roy

--
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

