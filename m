Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265095AbTLMPyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 10:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265143AbTLMPyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 10:54:11 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:36365 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S265095AbTLMPyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 10:54:08 -0500
From: Chris Vine <chris@cvine.freeserve.co.uk>
To: Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Sat, 13 Dec 2003 14:08:05 +0000
User-Agent: KMail/1.5.4
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <20031208135225.GT19856@holomorphy.com> <200312090123.31895.kernel@kolivas.org>
In-Reply-To: <200312090123.31895.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312131408.05558.chris@cvine.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 2:23 pm, Con Kolivas wrote:
> [snip original discussion thrashing swap on 2.6test with 32mb ram]
>
> Chris
>
> By an unusual coincidence I was looking into the patches that were supposed
> to speed up application startup and noticed this one was merged. A brief
> discussion with wli suggests this could cause thrashing problems on low
> memory boxes so can you try this patch? Applies to test11.

Con,

I have applied the patch, and performance is nearly indistinguishable from 
that with the kernel without it.

Chris.

