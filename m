Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVL1RiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVL1RiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVL1RiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:38:04 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:2186 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932541AbVL1RiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:38:03 -0500
Date: Wed, 28 Dec 2005 18:39:27 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific
 test-case (since 2.6.10-bk12)
Message-ID: <20051228183927.5e0a7561@localhost>
In-Reply-To: <20051228182323.7ec6d163@localhost>
References: <20051227190918.65c2abac@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<20051228120129.2a8d1199@localhost>
	<200512282219.24185.kernel@kolivas.org>
	<20051228123547.7d52501f@localhost>
	<20051228182323.7ec6d163@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2005 18:23:23 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> Usually transcode's prio go to 17/18 and DD runs in 15/20s, but
> sometimes it doesn't fluctuate staying stuck to 16 and DD runs in ~50s.

And now I've noticed that when that prority stops fluctuating, it stops
forever. Running the DD test again and again doesn't change anything!

For some reasons (running time?) the trancode priority is stuck to 16
and DD always performs very badly: ~50s (normally it should be 8s).

When I've noticed this the real running time of the trancode test is
about 35/40 min.

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-plugsched on x86_64
