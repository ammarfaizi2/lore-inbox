Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbULFILG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbULFILG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 03:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbULFILG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 03:11:06 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63658 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261317AbULFILE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 03:11:04 -0500
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Manfred Spraul <manfred@colorfullife.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200412051648.08283.kernel-stuff@comcast.net>
References: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de>
	 <200412051313.22581.kernel-stuff@comcast.net>
	 <1102278553.19406.4.camel@localhost>
	 <200412051648.08283.kernel-stuff@comcast.net>
Date: Mon, 06 Dec 2004 10:09:10 +0200
Message-Id: <1102320551.10063.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parag,

On Sun, 2004-12-05 at 16:48 -0500, Parag Warudkar wrote:
> I was not able to apply your patch which I copied from KMail - so
> looks like KMail is inserting some control chars.
> 
> So here is what I did - I applied your patch  to vmalloc.c manually
> and then modified vmalloc.c to include my changes. Attached is the new
> patch.
> If this doesn't work would you mind manually applying vfree() and
> vunmap() doc changes to your patch and submit?

I appreciate the help but please don't do this. You're creating more
work for me and confusion to the maintainers now. If Andrew already
picked up my patch, your new patch will not apply. If he didn't, he
cannot use your patch either because you left out the kfree() part
completely. Manfred said he would send a separate patch so please
respect that.

Andrew, please apply the original patch I sent and ignore the follow up
patches to this thread.

			Pekka

