Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262096AbREQRse>; Thu, 17 May 2001 13:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262106AbREQRsO>; Thu, 17 May 2001 13:48:14 -0400
Received: from www.wen-online.de ([212.223.88.39]:8718 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262096AbREQRsD>;
	Thu, 17 May 2001 13:48:03 -0400
Date: Thu, 17 May 2001 19:47:47 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Chris Evans <chris@scary.beasts.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.30.0105171815230.14119-100000@ferret.lmh.ox.ac.uk>
Message-ID: <Pine.LNX.4.33.0105171934210.366-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, Chris Evans wrote:

> On Thu, 17 May 2001, Alan Cox wrote:
>
> > 2.4.4-ac10
> [...]
> > 	- now 2.4.5pre vm seems sane dump other vmscan
> > 	  experiments
>
> Has anyone benched 2.4.5pre3 vs 2.4.4 vs. ?

Only doing parallel kernel builds.  Heavy load throughput is up,
but it swaps too heavily.  It's a little too conservative about
releasing cache now imho. (keeping about double what it should be
with this load.. easily [thump] tweaked;)

	-Mike

