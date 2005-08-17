Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVHQKIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVHQKIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 06:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVHQKIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 06:08:46 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:8207 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751036AbVHQKIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 06:08:46 -0400
To: hch@infradead.org
CC: kumar.gala@freescale.com, davem@davemloft.net, paulus@samba.org,
       galak@freescale.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, zach@vmware.com
In-reply-to: <20050817092041.GA12910@infradead.org> (message from Christoph
	Hellwig on Wed, 17 Aug 2005 10:20:41 +0100)
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
References: <20050816.203312.77701192.davem@davemloft.net> <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com> <20050817083048.GA11892@infradead.org> <E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu> <20050817090920.GA12716@infradead.org> <E1E5K1L-0004bH-00@dorka.pomaz.szeredi.hu> <20050817092041.GA12910@infradead.org>
Message-Id: <E1E5KpP-0004dy-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Aug 2005 12:07:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > They are provided by _one_ kernel, not necessarily the running kernel.
> 
> No, they're provided by packages like glibc-kernheaders or similar
> that are maintained separately.

Yes.  And "maintenance" I presume means "copy" the kernel headers and
do some cleanup to be compliant to the relevant standards (which the
kernel maintainers couldn't be bothered to do).

> They're split from the kernel headers and we don't need to keep
> obsolete junk around.

I agree about obsolete junk.

However statements like "No kernel headers can be included by userland
anymore" can be slightly misleading.

Miklos
