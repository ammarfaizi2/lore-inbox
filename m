Return-Path: <linux-kernel-owner+w=401wt.eu-S932130AbXAHIop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbXAHIop (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbXAHIop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:44:45 -0500
Received: from av2.karneval.cz ([81.27.192.122]:15903 "EHLO av2.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932130AbXAHIoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:44:44 -0500
X-Greylist: delayed 6210 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 03:44:44 EST
From: Pavel Pisa <ppisa@pikron.com>
Organization: PiKRON Ltd.
To: Philip Langdale <philipl@overt.org>
Subject: Re: [PATCH 2.6.19] mmc: Fix handling of response types in imxmmc and tifm drivers
Date: Sun, 7 Jan 2007 18:34:22 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       Alex Dubov <oakad@yahoo.com>, Sascha Hauer <s.hauer@pengutronix.de>
References: <459D178F.8000607@overt.org>
In-Reply-To: <459D178F.8000607@overt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701071834.22893.ppisa@pikron.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Philip,

On Thursday 04 January 2007 16:04, Philip Langdale wrote:
> This change depends on my SDHC patch and fixes a bug that was revealed
> during the development of that patch. The R6 response type should be
> identical to R1 (and R7) but was incorrectly defined differently. Fixing
> the R6 definition breaks assumptions in these two drivers that response
> type flags are unique. Pierre and Alex both believe that treating R6 and R7
> as R1 will be sufficient. ie: The controllers do not care about the
> differences between them. Due to lack of hardware, I have done no testing.

I have tested your patch.
Kernel builds. I have not found much time for testing.
But I would not like to block changes and I am going
for next week to project meeting in Spain, so there is
my reply.

I have 2.6.19 + realtime-patches rt14 on the hand.
I have been able to mount and use some cards, but it
I have observed some problems probably related to timing
when I have tried to change CPU frequency.

I need to find time to do more checking on vanilla and RT kernels
when I return. I have some ideas what could be enhanced to ensure
better MX1 SDHC cards recognition under RT kernels. I am not sure,
what causes other seen problems, but I have observed these things
on RT even without your patch.

Conclusion: I knowledge your patch and admit, that I need to
find time for my homeworks.

Best wishes

               Pavel Pisa


