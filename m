Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUBWVtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUBWVtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:49:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36557 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262049AbUBWVtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:49:03 -0500
Date: Mon, 23 Feb 2004 13:48:53 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: riel@redhat.com, herbert@13thfloor.at, mikpe@csd.uu.se,
       linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
Message-Id: <20040223134853.5947a414.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org>
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com>
	<Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 13:36:43 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Mon, 23 Feb 2004, Rik van Riel wrote:
> > On Sat, 21 Feb 2004, Linus Torvalds wrote:
> > 
> > > I'm really happy Intel finally got with the program,
> > 
> > With the program?  They still don't have an IOMMU ;)
> 
> Hmm.. Let's see what their chipsets will look like for this thing. Since
> they don't have an integrated memory controller, they can't very well do
> the IOMMU on the CPU, now can they?

You mean the PCI controller is in the CPU, else how else would you
accomplish this?

Or are you suggesting something else?

Really, not having an IOMMU on a 64-bit platform these days is basically like
pulling out one's toenails with an ice pick.
