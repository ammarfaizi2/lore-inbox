Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270700AbTG0Jh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 05:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270701AbTG0Jh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 05:37:56 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:52884
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270700AbTG0Jhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 05:37:42 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sun, 27 Jul 2003 19:57:01 +1000
User-Agent: KMail/1.5.2
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307271112570.7547-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0307271112570.7547-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271957.01597.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 19:24, Ingo Molnar wrote:
> On Sat, 26 Jul 2003, Felipe Alfaro Solana wrote:
> > [...] I feel that Con and Ingo work is starting to collide.
>
> they do collide only on the patch level - both change the same code.
> Otherwise, most of Con's tunings/changes are still valid with my patches
> applied - and i'd more than encourage Con's work to continue! Watching the
> tuning work i got the impression that the problem areas are suffering from
> a lack of infrastructure, not from a lack of tuning. So i introduced 3 new
> items: accurate statistics, on-runqueue boosting and timeslice
> granularity. The fact that these items improved certain characteristics
> (and fixed a couple of corner cases like test-starve.c) prove that it's a
> step in the right direction. It's definitely not the final step.

Thanks Ingo. I will continue then and stepwise make use of the extra 
infrastructure you've made available when I can decide how best to benefit 
from it.

Con

