Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272320AbTHIKkR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272321AbTHIKkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:40:17 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:64276 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id S272320AbTHIKkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:40:13 -0400
Date: Sat, 9 Aug 2003 11:18:03 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Jamie Lokier <jamie@shareable.org>
cc: Andrew Morton <akpm@osdl.org>, Grant Miner <mine0057@mrs.umn.edu>,
       <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: Re: Filesystem Tests
In-Reply-To: <20030809093337.GA28566@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.30.0308091028150.19108-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Aug 2003, Jamie Lokier wrote:
> reiser4 is using approximately twice the CPU percentage, but completes
> in approximately half the time, therefore it uses about the same
> amount of CPU time at the others.
>
> Therefore on a loaded system, with a load carefully chosen to make the
> test CPU bound rather than I/O bound, one could expect reiser4 to
> complete in approximately the same time as the others, _not_ slowest.

Depends how you define approximation, margins. I dropped them and
calculated reiser4 needs the most CPU time. Hans wrote it's worked on.

However guessing performance on a whatever carefully chosen loaded system
from results on an unloaded system is exactly that, guess, not fact.

> That's why it's misleading to draw conclusions from the CPU percentage alone.

I've never wrote I made my guesses from the CPU percentage alone, you
explained correctly why. I encourage you too to calculate yourself how
much more CPU time reiser4 needs.

	Szaka

