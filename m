Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310717AbSCQMuK>; Sun, 17 Mar 2002 07:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310728AbSCQMuB>; Sun, 17 Mar 2002 07:50:01 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:9999 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S310717AbSCQMtr>;
	Sun, 17 Mar 2002 07:49:47 -0500
Date: Sun, 17 Mar 2002 23:34:34 +1100
From: Anton Blanchard <anton@samba.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] 7.52 second kernel compile
Message-ID: <20020317123434.GE22387@krispykreme>
In-Reply-To: <20020316061535.GA16653@krispykreme> <E16m7u7-0007yv-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16m7u7-0007yv-00@w-gerrit2>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And this *without* the dcache_lock?  Hmm.  So you are saying there
> may still be room for improvement?

I tried the dcache lock patches but found it hard to see a difference,
for us the mm stuff still seems to be the bottleneck.

> BTW, are you doing this all out of cache/memory or do you have a
> disk/controller quick enough to do the initial little file reads that
> fast?

Yep its all out of cache, its slower on the first run.

Anton
