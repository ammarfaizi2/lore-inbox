Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbTG0JSa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 05:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269935AbTG0JSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 05:18:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:54504 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269144AbTG0JS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 05:18:29 -0400
Date: Sun, 27 Jul 2003 11:24:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Con Kolivas <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
In-Reply-To: <1059211833.576.13.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.44.0307271112570.7547-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Jul 2003, Felipe Alfaro Solana wrote:

> [...] I feel that Con and Ingo work is starting to collide.

they do collide only on the patch level - both change the same code.  
Otherwise, most of Con's tunings/changes are still valid with my patches
applied - and i'd more than encourage Con's work to continue! Watching the
tuning work i got the impression that the problem areas are suffering from
a lack of infrastructure, not from a lack of tuning. So i introduced 3 new
items: accurate statistics, on-runqueue boosting and timeslice
granularity. The fact that these items improved certain characteristics
(and fixed a couple of corner cases like test-starve.c) prove that it's a
step in the right direction. It's definitely not the final step.

	Ingo

