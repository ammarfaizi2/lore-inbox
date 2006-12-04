Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937425AbWLDV74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937425AbWLDV74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937423AbWLDV74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:59:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57802 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937427AbWLDV7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:59:55 -0500
Date: Mon, 4 Dec 2006 22:58:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in	latency_trace.c (take 3)
Message-ID: <20061204215840.GA23604@elte.hu>
References: <200611132252.58818.sshtylyov@ru.mvista.com> <4574149B.5070602@ru.mvista.com> <20061204153949.GA9350@elte.hu> <200612042256.51823.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612042256.51823.zippel@linux-m68k.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> While I'm not against this patch, but on m68k I prefer a 32bit cycle 
> type (however it's called), so it doesn't solve the original problem.

i havent changed the cycles_t type - it's still 32-bit. I agree with you 
that we dont want to bloat 32-bit arch-level code by artificially 
forcing everyone to a 64-bit cycles_t.

	Ingo
