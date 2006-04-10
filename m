Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWDJXdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWDJXdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWDJXdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:33:11 -0400
Received: from [4.79.56.4] ([4.79.56.4]:20110 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932173AbWDJXdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:33:10 -0400
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
From: Arjan van de Ven <arjan@infradead.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Michael Buesch <mb@bu3sch.de>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       netdev@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <20060410134625.GA25360@tuxdriver.com>
References: <20060410040120.GA4860@ens-lyon.fr>
	 <200604100607.33362.mb@bu3sch.de> <20060410042228.GN27596@ens-lyon.fr>
	 <200604100628.01483.mb@bu3sch.de>  <20060410134625.GA25360@tuxdriver.com>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 18:18:44 +0200
Message-Id: <1144685924.2876.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 09:46 -0400, John W. Linville wrote:
> On Mon, Apr 10, 2006 at 06:28:00AM +0200, Michael Buesch wrote:
> 
> > To summerize: I actually added these messages, because people were
> > hitting "this does not work with >1G" issues and did not get an error message.
> > So I decided to insert warnings until the issue is fixed inside the arch code.
> > I will remove them once the issue is fixed.
> 
> This sounds like the same sort of problems w/ the b44 driver.
> I surmise that both use the same (broken) DMA engine from Broadcom.
> 
> Unfortunately, I don't know of any good solution to this.  There are
> a few hacks in b44 that deal with the issue.  I don't like them,
> although I am the perpetrator of at least one of them.  It might be
> worth looking at what was done there?

or as better solution we should give i386 the swiommu code from
x86-64 ;)


