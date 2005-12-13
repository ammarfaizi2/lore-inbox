Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVLMFw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVLMFw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 00:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVLMFw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 00:52:29 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:11198 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932440AbVLMFw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 00:52:28 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: 2.6.15-rc5-mm2 :-)
Date: Tue, 13 Dec 2005 16:52:09 +1100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20051211041308.7bb19454.akpm@osdl.org> <291033443.20051211171237@dns.toxicfilms.tv>
In-Reply-To: <291033443.20051211171237@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131652.10117.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 December 2005 03:12, Maciej Soltysiak wrote:
> Hello Andrew,
>
> Sunday, December 11, 2005, 1:13:08 PM, you wrote:
> > - New CPU scheduler policy: SCHED_BATCH.
>
> Yes, Yes, Yesss. THANKS! Me not worthy, me bow before Con and Andrew ;-)
> As for apache/python voting rules, here's my +1 for vanilla inclusion.
>
> Anyway this makes me think. I remember Con saying that SCHED_BATCH relies
> on his staircase scheduler. I understand this is kind of a rewrite for
> the current scheduler, right?

Hi Maciej

I missed this announcement (been on leave for a while). This SCHED_BATCH 
implementation is by Ingo and it it is not "idle" scheduling as I have 
implemented in the staircase scheduler. This is just to restrict a task to 
not having any interactive bonus at any stage and to have predictable 
scheduling behaviour I guess.

Cheers,
Con
