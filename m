Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266328AbUBMAre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266591AbUBMArc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:47:32 -0500
Received: from ss1000-dmz.ms.mff.cuni.cz ([195.113.20.8]:60865 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266328AbUBMArb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:47:31 -0500
Date: Fri, 13 Feb 2004 01:47:27 +0100
From: Rudo Thomas <rudo@matfyz.cz>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug, or is it? - SCHED_RR and FPU related
Message-ID: <20040213004727.GA20680@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel@vger.kernel.org
References: <20040212205708.GA1679@ss1000.ms.mff.cuni.cz> <402C050B.2040803@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402C050B.2040803@cyberone.com.au>
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> xmms probably goes into an infinite loop, preventing anything else
> from being scheduled, right?

Nope. When I turn the suid bit off, xmms (does not run with SCHED_RR and) just
hangs consuming no CPU cycles. Strange.

I will look into it tomorrow, the invalid FP division was not the problem, its
results are.

Thanks.

Rudo.
