Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVBPFem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVBPFem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 00:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVBPFem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 00:34:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59037 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261990AbVBPFek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 00:34:40 -0500
Date: Wed, 16 Feb 2005 06:34:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Nathan Lynch <nathanl@austin.ibm.com>
Subject: Re: [PATCH] Run softirqs on proper processor on offline
Message-ID: <20050216053430.GA16766@elte.hu>
References: <20050211232821.GA14499@otto> <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com> <20050214215948.GA22304@otto> <20050215070217.GB13568@elte.hu> <20050216020628.GA25596@otto> <Pine.LNX.4.61.0502152227090.26742@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502152227090.26742@montezuma.fsmlabs.com>
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


* Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:

> Ensure that we only offline the processor when it's safe and never run 
> softirqs in another processor's ksoftirqd context. This also gets rid of 
> the warnings in ksoftirqd on cpu offline.
> 
> Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

looks good.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
