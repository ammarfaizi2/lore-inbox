Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUBTHcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267729AbUBTHcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:32:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20417 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267620AbUBTHcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:32:21 -0500
Date: Thu, 19 Feb 2004 23:32:14 -0800
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, greg@kroah.com, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB update for 2.6.3
Message-Id: <20040219233214.56f5b0ce.davem@redhat.com>
In-Reply-To: <1077261041.20787.1181.camel@gaston>
References: <20040220012802.GA16523@kroah.com>
	<Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	<1077256996.20789.1091.camel@gaston>
	<Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
	<1077258504.20781.1121.camel@gaston>
	<Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
	<1077259375.20787.1141.camel@gaston>
	<Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
	<20040219230407.063ef209.davem@redhat.com>
	<1077261041.20787.1181.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004 18:10:41 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Hrm... so if the USB device drivers are actually doing the dma mapping
> themselves, it make sense for them to pass their own struct device, no ?

That's right, at least that was the idea.

I get the impression though, based upon other posts in this thread, that
this scheme has basically been abandoned until 2.7.x or something like
that.
