Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVJFNjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVJFNjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVJFNjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:39:36 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:41903 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750931AbVJFNjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:39:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH] vm - swap prefetch v14
Date: Thu, 6 Oct 2005 23:42:06 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510052257.15713.kernel@kolivas.org> <200510052002.04173.ioe-lkml@rameria.de>
In-Reply-To: <200510052002.04173.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510062342.06735.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005 04:01 am, Ingo Oeser wrote:
> Hi Con,
>
> your patch still contains a serious BUG :-)
>
> On Wednesday 05 October 2005 14:57, Con Kolivas wrote:
> > -The tunable to determine the amount of data retrieved per prefetch was
> > added /proc/sys/vm/swap_prefetch
> > is used to decide how many groups of 128kb to prefetch per 1 second
> > interval and is set to 2 by default. It can be disabled by setting it to
> > 0
>
> swap_prefetch is not documented at Documentation/sysctl/vm.txt
>
> This simple text would suffice I think. Maybe comment about disabling it
> for laptop usage.

Thanks for the suggestion. I'll add the Documentation entry and you reminded 
me to do something specific with laptop mode which I have for v15 I'm about 
to announce.

Cheers,
Con
