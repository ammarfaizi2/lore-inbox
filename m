Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUHQXTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUHQXTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268512AbUHQXTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:19:44 -0400
Received: from web13903.mail.yahoo.com ([216.136.175.29]:40551 "HELO
	web13903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268511AbUHQXTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:19:43 -0400
Message-ID: <20040817231942.95635.qmail@web13903.mail.yahoo.com>
Date: Tue, 17 Aug 2004 16:19:42 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <411D50AE.5020005@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the actual server with a stress test, and I do eventually get timeouts.

I tried with what seemed to be the best setup earlier:
pb mode
max_ia_bonus set to 0

I tried several values for base_promotion_interval but the system eventually
times out after a few hours (it's still better than it used to be, with a stock
kernel, it timeouts in less than an hour).

Nicolas

