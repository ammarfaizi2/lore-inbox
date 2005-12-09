Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVLIK4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVLIK4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVLIK4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:56:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49314 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751308AbVLIK4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:56:04 -0500
Date: Fri, 9 Dec 2005 12:49:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Core Team <coreteam@netfilter.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Decrease number of pointer derefs in nf_conntrack_core.c
Message-ID: <20051209114935.GA26127@elte.hu>
References: <200512082336.19695.jesper.juhl@gmail.com> <20051209110441.GC20314@elte.hu> <9a8748490512090218q72998aebq8c09247921bd167e@mail.gmail.com> <Pine.LNX.4.63.0512091134100.31859@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512091134100.31859@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Schmielau <tim@physik3.uni-rostock.de> wrote:

> I get
> orig:
>    text    data     bss     dec     hex filename
>   11745      67     728   12540    30fc net/netfilter/nf_conntrack_core.o
> 
> patched:
>    text    data     bss     dec     hex filename
>   11681      67     728   12476    30bc net/netfilter/nf_conntrack_core.o

yeah, that's OK and in the expected range.

	Ingo
