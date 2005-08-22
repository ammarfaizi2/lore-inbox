Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVHVWXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVHVWXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVHVWWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:22:37 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:44424 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751381AbVHVWWd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:22:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WwfIDqkKYWumLaBKe1C5gSPebP+KZ1DJTyedXKX3LVWRlADR59mKsJCKQRYPGECundlnH7ZCYfg4rlY22+SQrZTze7tLd3705+QFYkCt18uaJs8Ed4tmuYQyMy3wwU3YcROjFhmbqx4XAdZOre5bR7+z7UYqpBVI2ZrQmtZ0G5Y=
Message-ID: <58cb370e050822022556595fa1@mail.gmail.com>
Date: Mon, 22 Aug 2005 11:25:43 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: David Hinds <dhinds@sonic.net>
Subject: Re: IRQ problem with PCMCIA
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Hesse, Christian" <mail@earthworm.de>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
In-Reply-To: <1124671082.1101.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508212043.58331.mail@earthworm.de>
	 <20050821221739.GA18925@sonic.net> <20050821221935.GB18925@sonic.net>
	 <1124671082.1101.0.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2005-08-21 at 15:19 -0700, David Hinds wrote
> > One caveat: I'm not sure if CardBus IDE devices are working under
> > Linux??  I'd think they should work with 2.6, but don't actually know
> > that for a fact.

CardBus IDE devices work just fine but there are still issues with
hotplug support (work in progress).

> They work with some patches to the core IDE code I did, but I've given

Alan has been living in his own reality for some time:

http://lkml.org/lkml/2005/5/2/123

> up ever getting those into the kernel. Please wait instead for the new
> SATA/ATA layer to develop hotplug support.

This is just a FUD to discourage people from working on IDE drivers.
Alan is doing this on purpose and doesn't really want to improve things.

Bartlomiej
