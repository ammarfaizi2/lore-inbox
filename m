Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUIFDYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUIFDYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 23:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267406AbUIFDYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 23:24:30 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:32434
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S264531AbUIFDY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 23:24:29 -0400
Date: Sun, 5 Sep 2004 20:22:15 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Daniel Roesen <dr@cluenet.de>
Cc: paul@clubi.ie, lkml@einar-lueck.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Message-Id: <20040905202215.5ed8bf5f.davem@davemloft.net>
In-Reply-To: <20040905230219.GA24688@srv01.cluenet.de>
References: <200409011441.10154.elueck@de.ibm.com>
	<Pine.LNX.4.61.0409011852380.2441@fogarty.jakma.org>
	<20040905230219.GA24688@srv01.cluenet.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004 01:02:19 +0200
Daniel Roesen <dr@cluenet.de> wrote:

> On Thu, Sep 02, 2004 at 05:22:01PM +0100, Paul Jakma wrote:
> > ip route add default via <gateway> src <virtual ip>
> 
> Sitenote: unfortunately, "src <...>" doesn't work for IPv6 routes, at
> least in 2.4 -- can someone confirm this problem to still exist in
> current 2.6?

That's right, no routing by source in ipv6 yet, the folks
working with the USAGI guys on MIPV6 support will add the
feature.
