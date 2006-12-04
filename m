Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937178AbWLDV5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937178AbWLDV5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937408AbWLDV5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:57:18 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:42868 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937178AbWLDV5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:57:16 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t =?iso-8859-1?q?in=09latency=5Ftrace=2Ec?= (take 3)
Date: Mon, 4 Dec 2006 22:56:50 +0100
User-Agent: KMail/1.9.5
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
References: <200611132252.58818.sshtylyov@ru.mvista.com> <4574149B.5070602@ru.mvista.com> <20061204153949.GA9350@elte.hu>
In-Reply-To: <20061204153949.GA9350@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612042256.51823.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 04 December 2006 16:39, Ingo Molnar wrote:

> there's *always* a way to do such things more cleanly - such as the
> patch below. Could you try to fix it up for 32-bit cycles_t platforms? I
> bet the hackery will be limited to now() and maybe the conversion
> routines, instead of spreading all around latency_trace.c.

While I'm not against this patch, but on m68k I prefer a 32bit cycle type 
(however it's called), so it doesn't solve the original problem.

bye, Roman
