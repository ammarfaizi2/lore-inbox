Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRD0U2q>; Fri, 27 Apr 2001 16:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136208AbRD0U2g>; Fri, 27 Apr 2001 16:28:36 -0400
Received: from www.wen-online.de ([212.223.88.39]:25350 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131158AbRD0U23>;
	Fri, 27 Apr 2001 16:28:29 -0400
Date: Fri, 27 Apr 2001 22:28:06 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Nigel Gamble <nigel@nrg.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: #define HZ 1024 -- negative effects?
In-Reply-To: <Pine.LNX.4.05.10104271221540.3283-100000@cosmic.nrg.org>
Message-ID: <Pine.LNX.4.33.0104272225120.354-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, Nigel Gamble wrote:

> > What about SCHED_YIELD and allocating during vm stress times?

snip

> A well-written GUI should not be using SCHED_YIELD.  If it is

I was refering to the gui (or other tasks) allocating memory during
vm stress periods, and running into the yield in __alloc_pages()..
not a voluntary yield.

	-Mike

