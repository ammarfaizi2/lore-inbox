Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270273AbSISHpu>; Thu, 19 Sep 2002 03:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270274AbSISHpu>; Thu, 19 Sep 2002 03:45:50 -0400
Received: from dsl-213-023-020-102.arcor-ip.net ([213.23.20.102]:10383 "EHLO
	starship") by vger.kernel.org with ESMTP id <S270273AbSISHpt>;
	Thu, 19 Sep 2002 03:45:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.35-mm1
Date: Thu, 19 Sep 2002 09:51:02 +0200
X-Mailer: KMail [version 1.3.2]
References: <3D858515.ED128C76@digeo.com>
In-Reply-To: <3D858515.ED128C76@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17rw5X-0000vG-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 09:15, Andrew Morton wrote:
> A 4x performance regression in heavy dbench testing has been fixed. The
> VM was accidentally being fair to the dbench instances in page reclaim.
> It's better to be unfair so just a few instances can get ahead and submit
> more contiguous IO.  It's a silly thing, but it's what I meant to do anyway.

Curious... did the performance hit show anywhere other than dbench?

-- 
Daniel
