Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272212AbRIWQur>; Sun, 23 Sep 2001 12:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272322AbRIWQuh>; Sun, 23 Sep 2001 12:50:37 -0400
Received: from maile.telia.com ([194.22.190.16]:24265 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S272212AbRIWQuZ>;
	Sun, 23 Sep 2001 12:50:25 -0400
Message-Id: <200109231648.f8NGmmK11359@maile.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Sun, 23 Sep 2001 18:43:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: safemode <safemode@speakeasy.net>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        george anzinger <george@mvista.com>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> <200109230042.f8N0gw129012@mailf.telia.com> <1001214128.873.26.camel@phantasy>
In-Reply-To: <1001214128.873.26.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 September 2001 05.02, Robert Love wrote:
> On Sat, 2001-09-22 at 20:38, Roger Larsson wrote:
> > Riels schedule in __alloc_pages probably helps the case with competing
> > regular processes a lot. Not allowing memory allocators to run their
> > whole time slot. The result should be a way to prioritize memory allocs
> > relative your priority. (yield part might be possible/good to remove)
>
> When did this go in?  I assume its in the 2.4.9-ac series and not
> 2.4.10?

2.4.0-test something...
It was removed when introducing Andreas VM

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
