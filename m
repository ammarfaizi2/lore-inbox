Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWDCWEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWDCWEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWDCWEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:04:40 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:10539 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751471AbWDCWEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:04:39 -0400
X-IronPort-AV: i="4.03,159,1141632000"; 
   d="scan'208"; a="421931853:sNHT36367226318"
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: updated InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
References: <ada7j6f8xwi.fsf@cisco.com> <ada1wwj1r7r.fsf@cisco.com>
	<20060402065810.GC1399@mellanox.co.il> <adahd5bwqob.fsf@cisco.com>
	<20060403220222.GB14847@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 03 Apr 2006 15:04:23 -0700
In-Reply-To: <20060403220222.GB14847@mellanox.co.il> (Michael S. Tsirkin's message of "Tue, 4 Apr 2006 01:02:22 +0300")
Message-ID: <adaek0etixk.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Apr 2006 22:04:24.0982 (UTC) FILETIME=[91BC3B60:01C6576A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> One thing I wanted to do was kill the global mutexes in
    Michael> ipoib, replacing all uses with priv->lock: we never do
    Michael> anything blocking there. Is this 2.6.17 material?

I don't have a strong feeling either way.  It doesn't fix anything,
but on the other hand it's a small low-risk cleanup.

 - R.
