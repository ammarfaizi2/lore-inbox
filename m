Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVAXXgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVAXXgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVAXXd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:33:26 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:34965 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261737AbVAXXch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:32:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AFrwxRq+dmimseu3lnAz494ZCJrKAuGk/onP6qUkaS/iU+rH3IeuSXDmEv/lEmxF8kb1KENLp7ZtmCjrqpDj/sL8qg7vYbjaoLyq4Xt/bHLUPG1kUb47f9G2qW2Xyi2AgWX6hF3LCnz3nTXUs5sw4cY5pGYhQH1nyTtT/LTlkLQ=
Message-ID: <58cb370e0501241532d078a01@mail.gmail.com>
Date: Tue, 25 Jan 2005 00:32:34 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Karsten Keil <kkeil@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
In-Reply-To: <20050124203624.GB14335@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124121226.GA29098@infradead.org>
	 <20050124203624.GB14335@pingi3.kke.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 21:36:24 +0100, Karsten Keil <kkeil@suse.de> wrote:
> On Mon, Jan 24, 2005 at 12:12:26PM +0000, Christoph Hellwig wrote:
> > > +i4l-new-hfc_usb-driver-version.patch
> >
> > this drivers wants:
> >
> >  - update for Documentation/CodingStyle
> 
> agree, I only take the patch from chip manufacturer and
> test compiling and working with my hardware and do not look at code style
> yet.
> 
> >  - conversion to proper pci API
> 
> ??? the driver is not PCI related at all

it seems that hch wanted to also mention this patch:

i4l-hfc-4s-and-hfc-8s-driver.patch

and it is indeed a very ugly one...
