Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269489AbUJFVUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269489AbUJFVUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269467AbUJFVUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:20:48 -0400
Received: from fmr03.intel.com ([143.183.121.5]:21977 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269500AbUJFVSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:18:38 -0400
Message-Id: <200410062118.i96LIC608654@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: RE: [patch] sched: auto-tuning task-migration
Date: Wed, 6 Oct 2004 14:18:27 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSr35RVF1I96YIsTJ+nN4Zaj5Zp+wACXX0Q
In-Reply-To: <20041006200439.GA15003@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Wednesday, October 06, 2004 1:05 PM
> could you try the replacement patch below - what results does it give?

By the way, I wonder why you chose to round down, but not up.


arch cache_decay_nsec: 10000000
migration cost matrix (cache_size: 9437184, cpu: 1500 MHz):
        [00]  [01]  [02]  [03]
[00]:    9.1   8.5   8.5   8.5
[01]:    8.5   9.1   8.5   8.5
[02]:    8.5   8.5   9.1   8.5
[03]:    8.5   8.5   8.5   9.1
min_delta: 8909202
using cache_decay nsec: 8909202 (8 msec)


