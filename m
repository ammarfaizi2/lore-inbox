Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316945AbSEWQ3i>; Thu, 23 May 2002 12:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316947AbSEWQ3h>; Thu, 23 May 2002 12:29:37 -0400
Received: from [62.70.58.70] ([62.70.58.70]:42896 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316945AbSEWQ3g> convert rfc822-to-8bit;
	Thu, 23 May 2002 12:29:36 -0400
Message-Id: <200205231629.g4NGTWE22956@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Thu, 23 May 2002 18:29:31 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200205231311.g4NDBO613726@mail.pronto.tv> <1486793366.1022140444@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Starting up 30 downloads from a custom HTTP server (or Tux - or Apache -
> > doesn't matter), file size is 3-6GB, download speed = ~4.5Mbps. After
> > some time the kernel (a) goes bOOM (out of memory) if not having any
> > swap, or (b) goes gong swapping out anything it can.
>
> How much RAM do you have, and what does /proc/meminfo
> and /proc/slabinfo say just before the explosion point?

I have 1 gig - highmem (not enabled) - 900 megs.
for what I can see, kernel can't reclaim buffers fast enough.
ut looks better on -aa.

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
