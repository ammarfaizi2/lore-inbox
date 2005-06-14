Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVFNAWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVFNAWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVFNAT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:19:29 -0400
Received: from colin.muc.de ([193.149.48.1]:47623 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261629AbVFNAMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 20:12:51 -0400
Date: 14 Jun 2005 02:12:49 +0200
Date: Tue, 14 Jun 2005 02:12:49 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: jesper.juhl@gmail.com, mru@inprovide.com, rommer@active.by,
       bernd@firmix.at, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: udp.c
Message-ID: <20050614001249.GF86745@muc.de>
References: <20050613230422.GA7269@gondor.apana.org.au> <20050613.162052.41635836.davem@davemloft.net> <m1fyvlbyp7.fsf@muc.de> <20050613.170045.74749212.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613.170045.74749212.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 05:00:45PM -0700, David S. Miller wrote:
> From: Andi Kleen <ak@muc.de>
> Date: Tue, 14 Jun 2005 01:53:56 +0200
> 
> > Still does, as does x86-64, but actually it could be changed now using
> > change_page_attr (and then later undoing it). Is it worth it?
> 
> A lot of bootup OOPS's have occured in the past and
> were never discovered until someone on a non-x86
> platform tested the patch.

Ok I can fix it, but only reasonably after mem_init (at least without
hacking up change_page_attr a lot to deal with bootmem).
Is that still worth it? 

-Andi
