Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVL1Xym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVL1Xym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 18:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVL1Xym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 18:54:42 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:49594 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932555AbVL1Xyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 18:54:41 -0500
Subject: Re: 2.6.15-rc5: latency regression vs 2.6.14 in
	exit_mmap->free_pgtables
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 19:00:18 -0500
Message-Id: <1135814419.7680.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 22:59 +0000, Hugh Dickins wrote:
> I wish you'd found it at -rc1 time.

Unfortunately this is the kind of thing that only could have been found
with Ingo's latency tracer, and the -rt patch set was not rebased to
2.6.15 until -rc5.

I'm not sure how much work it would be to break out CONFIG_LATENCY_TRACE
as a separate patch.

Thanks for the patch, I'll try it.

Lee



