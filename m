Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUBYIKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 03:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUBYIKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 03:10:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262345AbUBYIKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 03:10:21 -0500
Date: Wed, 25 Feb 2004 00:10:13 -0800
From: "David S. Miller" <davem@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Please back out the bluetooth sysfs support
Message-Id: <20040225001013.7c5e4a9b.davem@redhat.com>
In-Reply-To: <1077650761.2919.42.camel@pegasus>
References: <20040223103613.GA5865@lst.de>
	<20040223101231.71be5da2.davem@redhat.com>
	<1077560544.2791.63.camel@pegasus>
	<20040223184525.GA12656@lst.de>
	<1077582336.2880.12.camel@pegasus>
	<20040224004151.GF31035@parcelfarce.linux.theplanet.co.uk>
	<20040223232149.5dd3a132.davem@redhat.com>
	<1077621601.2880.27.camel@pegasus>
	<20040224100325.761f48eb.davem@redhat.com>
	<1077650761.2919.42.camel@pegasus>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 20:26:02 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> > Ok, if that is %100 true, then it's OK.
> 
> I went through the code to check it and we only use skb->dev between the
> HCI driver and the HCI core layer. All layers above are clean.

So I guess I should apply your fix, please resend to me under
seperate cover if you agree.
