Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWHVAHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWHVAHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWHVAHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:07:19 -0400
Received: from ns1.coraid.com ([65.14.39.133]:1222 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1750782AbWHVAHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:07:18 -0400
Date: Mon, 21 Aug 2006 18:45:40 -0400
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.18-rc4] aoe [10/13]: module parameter for device timeout
Message-ID: <20060821224540.GH2438@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com> <a47db3897e5de69fbe6bfaf1fea169a2@coraid.com> <1155942187.31543.26.camel@localhost.localdomain> <20060818231037.GW29988@coraid.com> <1155946151.31543.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155946151.31543.30.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 01:09:11AM +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-18 am 19:10 -0400, ysgrifennodd Ed L. Cashin:
> > No, this is just for users who need very fast failure.  The default
> > three minutes is good for things like short network interruptions and
> > even quick AoE device reboots, but users who aren't interested in that
> > kind of flexibility and want a fast failure generally want it always
> > and on every link.
> 
> Ok, but it should still be runtime settable.

You know, it occurs to me that it is, just by virtue of sysfs, and a
little test shows that to be the case.

-- 
  Ed L Cashin <ecashin@coraid.com>
