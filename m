Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268502AbUHQXI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268502AbUHQXI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUHQXI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:08:27 -0400
Received: from web13904.mail.yahoo.com ([216.136.175.67]:8578 "HELO
	web13904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268502AbUHQXI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:08:26 -0400
Message-ID: <20040817230825.4509.qmail@web13904.mail.yahoo.com>
Date: Tue, 17 Aug 2004 16:08:25 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040811093945.GA10667@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Ingo Molnar <mingo@elte.hu> wrote:

> 
> could you also try the 2.6.8-rc4-mm1 kernel? It has the array-switch
> disabled which _could_ lead to smoother timeslice distribution. It still
> has wakeup bonuses though.
> 
> 	Ingo

Sorry I didn't have the chance to try this test before: I didn't try it on
2.6.8.1-mm1 as I saw that maybe the patch related to the array sawitching was
dropped.

Anyway, I tried the test on 2.6.8-rc4-mm1 and it fails the test with 2 and 20
threads (delays of about 3 seconds for 2 threads, and 5 seconds with 20).

Nicolas

