Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbUKBM6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbUKBM6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUKBM6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:58:48 -0500
Received: from mx1.elte.hu ([157.181.1.137]:25219 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262992AbUKBM63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:58:29 -0500
Date: Tue, 2 Nov 2004 13:59:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove interactive credit
Message-ID: <20041102125930.GJ15290@elte.hu>
References: <418707CD.1080903@kolivas.org> <20041102123746.GB15290@elte.hu> <41878057.9000302@kolivas.org> <20041102124648.GF15290@elte.hu> <41878249.7040104@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41878249.7040104@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> >yeah, i know, it was the only piece of code from your earlier -Oint
> >scheduler-fixup series i almost didnt ack. But now it's in and testing
> >needs to cross at least one stable kernel boundary before it can be
> >taken out again. (unless a patch is an obvious or important fix.)
> 
> I've been extensively testing it at this end and recommend giving it a
> good -mm run. I'm reasonably sure it's related to some of the
> disproportionate cpu usage reports we've seen with some of those bash
> script examples (can't recall the details now so I'll need to chase
> them up). If I didn't suspect it was an issue I wouldn't be keen to
> undo something either.

i'm too quite positive about the expected effects. -mm testing will
tell.

	Ingo
