Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUGDWBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUGDWBn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUGDWBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:01:43 -0400
Received: from smtp08.web.de ([217.72.192.226]:28323 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S265805AbUGDWBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:01:42 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.7: sk98lin unload oops
Date: Mon, 5 Jul 2004 00:01:35 +0200
User-Agent: KMail/1.6.2
References: <200407041342.18821.bernd-schubert@web.de> <200407042028.59047.bernd-schubert@web.de> <20040704184404.GA7262@infradead.org>
In-Reply-To: <20040704184404.GA7262@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407050001.46489.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sorry, it's for Linus' current BK tree.  I've attached three files that
> you should be able to just copy over your regular 2.6.7 tree:

Thanks, this driver compiles fine.


[from your other mail]
> the previous one) makes it work unless you change the interface name
> manually, but as Linux explicitly allows that the interface is
> fundamentally broken and probably should just go away.

Unfortunality we rename all interfaces using ifrename to make sure that the 
interface names won't change with different kernel versions (we have this 
problem when we switch between 2.4. and 2.6.). So it is normal that the oops 
occurs on unloading the modules?


Btw, on 22th June I got another skge.c patch from Herbert Xu to fix another 
oops:

http://lkml.org/lkml/2004/6/22/44

This patch applies fine on top of your new versions (with 400 lines offset), 
maybe this patch should also be included into the current BK tree?

Thanks a lot,
	Bernd
