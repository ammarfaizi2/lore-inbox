Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUKKWA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUKKWA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbUKKV6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:58:39 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:39955 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262380AbUKKV5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:57:44 -0500
Message-ID: <4193E056.6070100@tebibyte.org>
Date: Thu, 11 Nov 2004 22:57:42 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet>
In-Reply-To: <20041111112922.GA15948@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti escreveu:
> This is an improved version of OOM-kill-from-kswapd patch.

It seems good. My normal repeatable test of building umlsim on my 64MB 
P2 builds fine with this patch. On recent unpatched kernels it's 
guaranteed to fail when the oom killer strikes at the linking stage.

Regards,
Chris R.
