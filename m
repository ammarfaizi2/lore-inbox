Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSHGWrU>; Wed, 7 Aug 2002 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSHGWrU>; Wed, 7 Aug 2002 18:47:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37650 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314395AbSHGWrS>;
	Wed, 7 Aug 2002 18:47:18 -0400
Message-ID: <3D51A3C9.8CAABAA4@zip.com.au>
Date: Wed, 07 Aug 2002 15:48:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [PATCH] Rmap speedup
References: <Pine.LNX.4.44L.0208071753190.23404-100000@imladris.surriel.com> <E17cZBB-000503-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ..
> > Not to mention the superfluous IO being scheduled today.
> 
> Yes, well at this point we're suppose to demonstrate how much better
> rmap does on that, are we not.

Well let it be said that the 2.5.30 VM is by no means "Rik's
rmap VM".  It's the 2.4.15 VM with pte-chains bolted on the side,
and it's fairly sucky in several regards.

Until the big stuff is settled in (locking rework, per-zone LRU,
slablru, ...) there's not a lot of point trying to finetune
the 2.5.30 VM.

But a convincing demonstration of the advantages of the 2.4 rmap
patch would set a lot of minds at ease ;)
