Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVHBOJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVHBOJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVHBOHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:07:23 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:27652 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261526AbVHBOEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:04:46 -0400
Date: Tue, 2 Aug 2005 16:04:41 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Stelian Pop <stelian@popies.net>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Erik Waling <erikw@acc.umu.se>
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050802140440.GA5580@roarinelk.homelinux.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> <42EC9410.8080107@roarinelk.homelinux.net> <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org> <Pine.LNX.4.58.0507311125360.29650@g5.osdl.org> <1122846072.17880.43.camel@deep-space-9.dsnet> <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org> <1122907067.31357.43.camel@localhost.localdomain> <1122976168.4656.3.camel@localhost.localdomain> <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050802154022.A15794@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 03:40:22PM +0400, Ivan Kokshaysky wrote:
> On Tue, Aug 02, 2005 at 12:32:26PM +0200, Manuel Lauss wrote:
> > Does not work on -rc4-mm1. The IO-ports pre-reserved message appears,
> > though. The 2 io-regions are still located under the "CardBus #03"
> > device. Re-Applying
> > "revert-gregkh-pci-pci-assign-unassigned-resources.patch" makes it
> > work again.
> 
> Does the patch in appended message fix that?

Indeed, it does fix it (vanilla -rc4-mm1 and your patch)

Thanks!

-- 
 Manuel Lauss
