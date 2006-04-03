Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWDCWBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWDCWBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWDCWBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:01:05 -0400
Received: from [194.90.237.34] ([194.90.237.34]:32946 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964868AbWDCWBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:01:03 -0400
Date: Tue, 4 Apr 2006 01:02:22 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: updated InfiniBand 2.6.17 merge plans
Message-ID: <20060403220222.GB14847@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <ada7j6f8xwi.fsf@cisco.com> <ada1wwj1r7r.fsf@cisco.com> <20060402065810.GC1399@mellanox.co.il> <adahd5bwqob.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adahd5bwqob.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 03 Apr 2006 22:03:56.0687 (UTC) FILETIME=[80DEC1F0:01C6576A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rdreier@cisco.com>:
> Subject: Re: updated InfiniBand 2.6.17 merge plans
> 
>     Michael> These are just the features, right? There's as the usual
>     Michael> bugfixes which aren't listed here.
> 
> Yes, of course.  We can always merge bugfixes.  Although I don't know
> of any pending bugfixes that are not at least in my for-2.6.17 branch...

One thing I wanted to do was kill the global mutexes in
ipoib, replacing all uses with priv->lock: we never do anything blocking
there. Is this 2.6.17 material?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
