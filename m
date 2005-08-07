Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752770AbVHGVUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbVHGVUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbVHGVUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:20:49 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:29627 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1752770AbVHGVUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:20:49 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Sun, 7 Aug 2005 23:20:46 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Martin Braun <mbraun@uni-hd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.6.13-rc5 on webserver with raid
Message-ID: <20050807212046.GB1864@localhost.localdomain>
References: <42F336CF.7020001@uni-hd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F336CF.7020001@uni-hd.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 11:52:15AM +0200 Martin Braun wrote:

> Hi,
> 
> I've been trying to upgrade kernel to 2.6.13-rc5. The server boots
> normally w/o errors, but after while (from 5 minutes up to 2 hours) the
> Kernel hangs (no keyboard input possible). As I am a newbie I cannot
> figure out who will be concerned with this error.

Please don't run ksymoops on 2.6 kernels, it makes the output look
weird and isn't necessary anymore.

> 
> >>EIP; c0324afd <tcp_tso_should_defer+fd/110>   <=====
>

Should be fixed in 2.6.13-rc6, if problem persists please report back.
