Return-Path: <linux-kernel-owner+w=401wt.eu-S1754516AbWLRUIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbWLRUIS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbWLRUIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:08:18 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:28127 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbWLRUIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:08:16 -0500
Date: Mon, 18 Dec 2006 22:08:12 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] OSS: replace kmalloc()+memset() combos with kzalloc()
Message-ID: <20061218200812.GF3548@rhun.ibm.com>
References: <Pine.LNX.4.64.0612181447001.6439@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612181447001.6439@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 02:53:05PM -0500, Robert P. J. Day wrote:
> 
>   Replace kmalloc() + memset() pairs with the appropriate kzalloc()
> calls.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   i could have sworn i submitted this patch a while back but it
> doesn't seem to have been applied.  it's possible it's still in the
> queue somewhere but it seems unlikely at this point.

The OSS subsystem doesn't have an overall maintainer, for patches like
this you should probably CC akpm (CC'd). Also, ack on the trident
bits.

Cheers,
Muli
