Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUBYRlG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbUBYRlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:41:06 -0500
Received: from linux-bt.org ([217.160.111.169]:48807 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261478AbUBYRlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:41:00 -0500
Subject: Re: Please back out the bluetooth sysfs support
From: Marcel Holtmann <marcel@holtmann.org>
To: "David S. Miller" <davem@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040225001013.7c5e4a9b.davem@redhat.com>
References: <20040223103613.GA5865@lst.de>
	 <20040223101231.71be5da2.davem@redhat.com>
	 <1077560544.2791.63.camel@pegasus> <20040223184525.GA12656@lst.de>
	 <1077582336.2880.12.camel@pegasus>
	 <20040224004151.GF31035@parcelfarce.linux.theplanet.co.uk>
	 <20040223232149.5dd3a132.davem@redhat.com>
	 <1077621601.2880.27.camel@pegasus>
	 <20040224100325.761f48eb.davem@redhat.com>
	 <1077650761.2919.42.camel@pegasus>
	 <20040225001013.7c5e4a9b.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1077730823.2919.133.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 18:40:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> > > Ok, if that is %100 true, then it's OK.
> > 
> > I went through the code to check it and we only use skb->dev between the
> > HCI driver and the HCI core layer. All layers above are clean.
> 
> So I guess I should apply your fix, please resend to me under
> seperate cover if you agree.

if nobody else has complains about this patch I will test it a last time
on a different machine and then drop you a note where you can pull it
from.

Regards

Marcel


