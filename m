Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbUBWWGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbUBWWGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:06:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39642 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262058AbUBWWGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:06:54 -0500
Date: Mon, 23 Feb 2004 14:06:47 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: riel@redhat.com, herbert@13thfloor.at, mikpe@csd.uu.se,
       linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
Message-Id: <20040223140647.73bdf091.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0402231359280.3005@ppc970.osdl.org>
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com>
	<Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org>
	<20040223134853.5947a414.davem@redhat.com>
	<Pine.LNX.4.58.0402231359280.3005@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 14:08:40 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> In fact, I _think_ you could actually use the AGP bridge as a strange
> IOMMU. Of course, right now their AGP bridges are all 32-bit limited
> anyway, but the point being that they at least in theory would seem to
> have the capability to do this.

Ok, I see.  In fact, I remember some vague notion that the AGP bridge
on the Athlon's could technically be used as a full-on IOMMU, especially
since it was all derived from Alpha PCI chipsets which did use things
this way.
