Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUGKGqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUGKGqg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 02:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUGKGqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 02:46:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29853 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266250AbUGKGqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 02:46:34 -0400
Date: Sun, 11 Jul 2004 08:47:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck kernel mailing list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040711064730.GA11254@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org> <40F016D9.8070300@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F016D9.8070300@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Ooops forgot to mention this was running reiserFS 3.6 on software
> raid0 2x IDE with cfq elevator.

ok, reiserfs (and all journalling fs's) definitely need a look - as you
can see from the ext3 mods in the patch. Any chance you could try ext3
based tests? Those are the closest to my setups.

	Ingo
