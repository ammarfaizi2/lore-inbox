Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTEUINT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTEUINL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 04:13:11 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:15236 "EHLO
	mwinf0403.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262033AbTEUILi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 04:11:38 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/14] USB speedtouch update
Date: Wed, 21 May 2003 10:24:38 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200305210049.24619.baldrick@wanadoo.fr> <20030521020732.GA7939@kroah.com>
In-Reply-To: <20030521020732.GA7939@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305211024.38553.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've applied all of these to my tree, but I didn't apply the following
> to Linus's tree because they just didn't apply.  I tried to fix up a few
> by hand, and got some of them to work, but eventually gave up on the
> rest.  So here's a list of the ones that didn't go into Linus's tree:
> 	USB speedtouch: use optimally sized reconstruction buffers
> 	USB speedtouch: send path micro optimizations
> 	USB speedtouch: kfree_skb -> dev_kfree_skb
> 	USB speedtouch: receive code rewrite
>
> Also this one didn't go into Linus's tree, as it's already there:
> 	USB speedtouch: remove MOD_XXX_USE_COUNT
>
> So, any patches against Linus's latest bk tree to bring the above into
> sync would be appreciated.

I think the problem is that you forgot to apply this one to Linus's tree:

[PATCH 02/14] USB speedtouch: trivial whitespace and name changes

Ciao,

Duncan.
