Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267238AbUHIVY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267238AbUHIVY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267264AbUHIVYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:24:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24031 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267232AbUHIVV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:21:59 -0400
Date: Mon, 9 Aug 2004 14:20:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, bjorn.helgaas@hp.com, akpm@osdl.org, ehm@cris.com,
       grif@cs.ucr.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
Message-Id: <20040809142012.23dc22af.davem@redhat.com>
In-Reply-To: <20040809221529.A10454@infradead.org>
References: <200408091252.58547.bjorn.helgaas@hp.com>
	<20040809210335.A9711@infradead.org>
	<20040809141155.0c94b8c4.davem@redhat.com>
	<20040809221529.A10454@infradead.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004 22:15:29 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Aug 09, 2004 at 02:11:55PM -0700, David S. Miller wrote:
> > You could remove the qlogicfc driver if you really wanted, by providing
> > a config option that would provide qlogicfc compatible device numbering
> > in the qla2xxx driver.
> 
> It's called CONFIG_DEVFS.  disable this config option (it's marked OBSOLETE anyway)
> and your device names are the same.

I wish to do 2.4.x and 2.6.x development on the same system.
Is this such a foreign concept for you?
