Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVF2TkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVF2TkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVF2Tja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:39:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22252 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262536AbVF2Tik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:38:40 -0400
Date: Wed, 29 Jun 2005 21:38:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050629193804.GA6256@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050629070058.GA15987@elte.hu> <Pine.LNX.4.58.0506290159050.12101@echo.lysdexia.org> <200506291648.16601.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506291648.16601.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> attached patch for io_apic.c lets
> 1. gcc 3.4.3 optimize io_apic access a little better.
> 2. CONFIG_X86_UP_IOAPIC_FAST work here.
>    Didn't check, if it really speeds up things.

which change made CONFIG_X86_UP_IOAPIC_FAST work on your box? It seems 
you've changed the per-register frontside read-cache to something else - 
was that on purpose?

	Ingo
