Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWITLV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWITLV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 07:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWITLV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 07:21:57 -0400
Received: from mx2.go2.pl ([193.17.41.42]:63659 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751129AbWITLV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 07:21:56 -0400
Date: Wed, 20 Sep 2006 13:25:59 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, luizluca@gmail.com
Subject: Re: [PATCH] Adds kernel parameter to ignore pci devices
Message-ID: <20060920112559.GC1697@ff.dom.local>
References: <20060920064114.GA1697@ff.dom.local> <1158748734.7705.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158748734.7705.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 11:38:53AM +0100, Alan Cox wrote:
> Ar Mer, 2006-09-20 am 08:41 +0200, ysgrifennodd Jarek Poplawski:
> > On 20-09-2006 02:01, Alan Cox wrote:
> > > Not sure its the way I'd approach it - in your specific case it should
> > > be easier to just not compile in EHCI (USB 2.0) support.
> >  
> > I'd dare to vote for this idea: it's good for testing
> > and very practical eg. for comparing performance of similar
> > devices like network or sound cards. Besides: ehci could
> > work for other devices.
> 
> In which case you'd need to specify the device to ignore by its PCI bus
> address so could ignore one device but not another of the same type. Eg
> pci=ignore=0:4.5

If I correctly understand this as a doubt I mean doing this in grub
or lilo as boot variants.

Jarek P.
