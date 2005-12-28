Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVL1Iwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVL1Iwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 03:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVL1Iwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 03:52:49 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:62686 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932511AbVL1Iwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 03:52:49 -0500
Date: Wed, 28 Dec 2005 09:53:28 +0100
From: DervishD <lkml@dervishd.net>
To: Shaun <mailinglists@unix-scripts.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory, where's it going?
Message-ID: <20051228085328.GA25380@DervishD>
Mail-Followup-To: Shaun <mailinglists@unix-scripts.com>,
	linux-kernel@vger.kernel.org
References: <dotjb6$j8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dotjb6$j8$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Shaun :)

 * Shaun <mailinglists@unix-scripts.com> dixit:
> I see that free shows that 7.7GB is cached and i'm not sure why so
> much is cached.

    Because free memory is a *waste* of memory. Why leaving unused
memory when it can be used for caching? The kernel will (up to some
extent, I suppose) try to use all free memory for caching if no app
needs it.

    If you have 8GB of memory, it's a bit difficult to fill it just
with the running apps, so the kernel cleverly uses the rest for
caching things so the system runs faster.

    For example, I have 1GB of RAM, and even when I use X (seldom...)
I never eat up more than, let's say, 500MB. So, I have another 500MB
of memory unused: the kernel uses it as cache, and that makes my
system run much faster (I noticed a speed increase when I switch from
512 to 1G).

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
