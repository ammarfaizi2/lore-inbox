Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbTHTEzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 00:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTHTEzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 00:55:09 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:10219
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S261713AbTHTEzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 00:55:06 -0400
Date: Wed, 20 Aug 2003 06:55:15 +0200
From: Voluspa <lista1@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O17int
Message-Id: <20030820065515.059654d6.lista1@comhem.se>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-08-19 15:01:28 Con Kolivas wrote:

> Food for the starving masses.
>
> This patch prevents any single task from being able to starve the
> runqueue that it's on.

This is completely tru in my two test scenarios. Winex 3.1 running
"Baldurs Gate I" is as smooth as -O10 or -A3 and it is impossible to
trigger a permanent starvation. Switching to a text console and back, I
only hear brief, ca 1.5 seconds, "sound repeats" after which the game
recovers totally. Clicking the "Software standard BLT[on/off]", that
even triggered a short priority inversion in A3, has no impact at all.
Playability, for those who wonder, is an impressive 9 out of 10 ;-)

Blender 2.28 can not starve xmms one iota. Within blender itself, I can
cause 1 to 5 second freezes while doing a slow "world rotate", but that
is something the application programmers have to fix.

I see no throughput regression, and overall "feel" of the system is
great. A real keeper, this one.

Mvh
Mats Johannesson
