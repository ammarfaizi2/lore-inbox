Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUGKJy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUGKJy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 05:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUGKJy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 05:54:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10429 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266541AbUGKJyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 05:54:13 -0400
Date: Sun, 11 Jul 2004 11:50:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040711095039.GA22391@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <20040711093209.GA17095@elte.hu> <20040711024518.7fd508e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711024518.7fd508e0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > For all the
> >  other 200 might_sleep() points it doesnt matter much.
> 
> Sorry, but an additional 100 might_sleep()s is surely excessive for
> debugging purposes, and unneeded for latency purposes: all these sites
> are preemptible anyway.

nono, i mean the existing ones. (it's 116 not 200) There's no plan to
add another 100, you've seen all the ones we found to be necessary for
this.

	Ingo
