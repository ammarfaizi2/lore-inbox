Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVBVSP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVBVSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVBVSP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:15:58 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:20926
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261197AbVBVSPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:15:53 -0500
Date: Tue, 22 Feb 2005 10:14:47 -0800
From: "David S. Miller" <davem@davemloft.net>
To: John Heffner <jheffner@psc.edu>
Cc: shemminger@osdl.org, mlists@danielinux.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, ccaini@deis.unibo.it,
       rfirrincieli@arces.unibo.it
Subject: Re: [PATCH] TCP-Hybla proposal
Message-Id: <20050222101447.68a02c12.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0502221247130.22393@dexter.psc.edu>
References: <200502221534.42948.mlists@danielinux.net>
	<20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
	<Pine.LNX.4.58.0502221247130.22393@dexter.psc.edu>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 13:03:11 -0500 (EST)
John Heffner <jheffner@psc.edu> wrote:

> An idea I've been toying with for a while now is completely abstracting
> congestion control.  Then you could have congestion control loadable
> modules, which would avoid this mess of experimental algorithms inside the
> main-line kernel.  If done right, they might be able to work seamlessly
> with SCTP, too.  The tricky part is making sure the interface is complete
> enough.

The symbols exported to allow this would need to be EXPORT_SYMBOL_GPL().
