Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVL1LeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVL1LeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 06:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVL1LeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 06:34:24 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:44215 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S964786AbVL1LeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 06:34:24 -0500
Date: Wed, 28 Dec 2005 12:35:47 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific
 test-case (since 2.6.10-bk12)
Message-ID: <20051228123547.7d52501f@localhost>
In-Reply-To: <200512282219.24185.kernel@kolivas.org>
References: <20051227190918.65c2abac@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<20051228120129.2a8d1199@localhost>
	<200512282219.24185.kernel@kolivas.org>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2005 22:19:23 +1100
Con Kolivas <kernel@kolivas.org> wrote:

> This latter thing sounds more like your transcode job pushed everything out to 
> swap... You need to instrument this case better.
> 

I don't know. The combination Swapped Out Programs + "normal" priority
strangeness can potentially result in a total disaster... but why
renicing transcode to "0" gets the system usable again?

Next time I'll grab "/proc/meminfo"... and what other info can help to
understand?

-- 
	Paolo Ornati
	Linux 2.6.15-rc5-plugsched on x86_64
