Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVG2Ikq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVG2Ikq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVG2Ikp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:40:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8643 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262477AbVG2IjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:39:11 -0400
Date: Fri, 29 Jul 2005 10:38:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Michael Kerrisk <mtk-manpages@gmx.net>, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net, akpm@osdl.org, chrisw@osdl.org
Subject: Re: Broke nice range for RLIMIT NICE
Message-ID: <20050729083850.GB7302@elte.hu>
References: <32710.1122563064@www32.gmx.net> <20050729061318.GD7425@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729061318.GD7425@waste.org>
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


* Matt Mackall <mpm@selenic.com> wrote:

> The other downside is, this obviously changes any existing configs 
> actually using this by one nice level..

it's pretty harmless, and i doubt the use of this is all that wide (if 
existent at all - utilities have not been updated yet). Lets fix it 
ASAP, preferably in 2.6.13.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
