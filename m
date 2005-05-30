Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVE3K4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVE3K4c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVE3K4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:56:31 -0400
Received: from colin.muc.de ([193.149.48.1]:22282 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261401AbVE3K4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:56:21 -0400
Date: 30 May 2005 12:56:18 +0200
Date: Mon, 30 May 2005 12:56:18 +0200
From: Andi Kleen <ak@muc.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Takashi Iwai <tiwai@suse.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050530105618.GL86087@muc.de>
References: <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de> <s5hwtpkwz4z.wl@alsa2.suse.de> <20050530095349.GK86087@muc.de> <20050530103347.GA13425@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530103347.GA13425@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FYI, to get good latencies for jack you currently need the -RT tree and 
> CONFIG_PREEMPT. (see Lee Revell's and Rui Nuno Capela's extensive tests)

Yeah, but you did a lot of (often unrelated to rt preempt) latency fixes in RT
that are not yet merged into mainline. When they are all merged
things might be very different. And then there can be probably
more fixes.

No matter what you do with RT this is needed anyways because
the standard non preempt kernel needs to have reasonable latencies too.


-Andi
