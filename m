Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUFCNfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUFCNfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUFCNf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 09:35:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60634 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262215AbUFCNfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:35:25 -0400
Date: Thu, 3 Jun 2004 15:10:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040603131007.GB3915@openzaurus.ucw.cz>
References: <1CC443CDA50AF2indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1CC443CDA50AF2indou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Although I know about LKCD and netdump, I'm developing yet another crash
> dump, which is a polling-based disk dump as netdump do. Because it
> disables any interrupts during doing dump, it can avoid lots of problems
> LKCD has.
> 
> Main Feature
> - Reliability
>    Diskdump disables interrupts, stops other cpus and writes to the 
>    disk with polling mode. Therefore, unnecessary functions(like
>    interrupt handler) don't disturb dumping.

Hmm... with this, better design of swsusp mifht be feasible.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

