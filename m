Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270426AbTGPInE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270460AbTGPInD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:43:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6570 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270426AbTGPInB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:43:01 -0400
Date: Wed, 16 Jul 2003 10:55:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Sean Neakums <sneakums@zork.net>
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.6.0-test1-mm1
In-Reply-To: <6uwueidhdd.fsf@zork.zork.net>
Message-ID: <Pine.LNX.4.44.0307161052310.6193-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jul 2003, Sean Neakums wrote:

> [...] If I keep running 'ps aux' its output does start to become slow
> again, snapping back to full speed after a few more runs.  Kind of an
> odd one.

there was a similar bug in the gnome terminal code, it was a userspace X
window-refresh/event-qeueing bug/race that was sensitive to scheduler
timings. So it can go away and come back based on precise timings. Eg. it
was more likely to happen with antialiasing turned on than off.

	Ingo

