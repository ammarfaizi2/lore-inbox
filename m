Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVKMBrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVKMBrL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 20:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVKMBrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 20:47:10 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:65453 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750805AbVKMBrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 20:47:09 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] plugsched - update Kconfig-1
Date: Sun, 13 Nov 2005 12:44:47 +1100
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <434F01EA.6060709@bigpond.net.au> <200511111417.03859.kernel@kolivas.org> <43769834.7080804@bigpond.net.au>
In-Reply-To: <43769834.7080804@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511131244.48358.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2005 12:34, Peter Williams wrote:
> Con Kolivas wrote:
> > Here's a respin just changing the spa menu.
>
> While agreeing that PlugSched's configuration needs overhaul I don't
> think this is it as it just makes things more confusing.  I'll put
> fixing the configuration code on my list of things to do.  They main
> changes I see as necessary are:
>
> 1. Make the ability to select which schedulers are built in independent
> of EMBEDDED.
> 2. Only offer builtin schedulers as choice for the default scheduler.
> 3. Only build in ingosched if PLUGSCHED is not configured.

I disagree with 3. Surely people might want to build in only one scheduler 
that is not ingosched without other choices.

Cheers,
Con
