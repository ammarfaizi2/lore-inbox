Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUGWFh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUGWFh6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 01:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267550AbUGWFh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 01:37:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36766 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267549AbUGWFh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 01:37:56 -0400
Date: Fri, 23 Jul 2004 07:39:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jack Steiner <steiner@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] - Initialize sched domain table
Message-ID: <20040723053907.GB13215@elte.hu>
References: <20040723010257.GA27350@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723010257.GA27350@sgi.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jack Steiner <steiner@sgi.com> wrote:

> Here is a trivial patch that is required to boot the latest 2.6.7 tree 
> on the SGI 512p system.
> 
> 	Initial the busy_factor in the sched_domain_init table.
> 	Otherwise, booting hangs doing excessive load balance
> 	operations.
> 
> 	Signed-off-by: Jack Steiner <steiner@sgi.com>

looks good.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
