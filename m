Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVJQHXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVJQHXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVJQHXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:23:49 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:46979 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932097AbVJQHXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:23:49 -0400
Date: Mon, 17 Oct 2005 11:23:37 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: andrea@suse.de, herbert@gondor.apana.org.au, nickpiggin@yahoo.com.au,
       benh@kernel.crashing.org, hugh@veritas.com, paulus@samba.org,
       anton@samba.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
Message-ID: <20051017112337.A18204@jurassic.park.msu.ru>
References: <20051015200701.GP18159@opteron.random> <20051015.160702.128767261.davem@davemloft.net> <20051016233600.A13487@jurassic.park.msu.ru> <20051016.212917.34746449.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051016.212917.34746449.davem@davemloft.net>; from davem@davemloft.net on Sun, Oct 16, 2005 at 09:29:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2005 at 09:29:17PM -0700, David S. Miller wrote:
> Even a quick google tells me that on Alpha, LL/SC have implicit
> barriers only with respect to the locations being acted upon
> by the LL/SC, but don't have more general barrier properties.

Argh, you are right - I should have read the manual before posting...

Ivan.
