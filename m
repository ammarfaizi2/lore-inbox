Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUIOVkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUIOVkD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUIOVhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:37:16 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:19643
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267585AbUIOVfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:35:07 -0400
Date: Wed, 15 Sep 2004 14:29:26 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, paul@clubi.ie, netdev@oss.sgi.com,
       leonid.grossman@s2io.com, linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
Message-Id: <20040915142926.7bc456a4.davem@davemloft.net>
In-Reply-To: <4148B2E5.50106@pobox.com>
References: <4148991B.9050200@pobox.com>
	<Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
	<1095275660.20569.0.camel@localhost.localdomain>
	<4148A90F.80003@pobox.com>
	<20040915140123.14185ede.davem@davemloft.net>
	<20040915210818.GA22649@havoc.gtf.org>
	<20040915141346.5c5e5377.davem@davemloft.net>
	<4148B2E5.50106@pobox.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 17:23:49 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> The typical definition of TOE is "offload 90+% of the net stack", as 
> opposed to "TCP assist", which is stuff like TSO.

I think a better goal is "offload 90+% of the net stack cost" which
is effectively what TSO does on the send side.

This is why these discussions are so circular.

If we want to discuss something specific, like receive offload
schemes, that is a very different matter.  And I'm sure folks
like Rusty have a lot to contribute in this area :-)

