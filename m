Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUIOU6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUIOU6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUIOU4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:56:42 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:54714
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267433AbUIOUzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:55:41 -0400
Date: Wed, 15 Sep 2004 13:53:08 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: paul@clubi.ie, netdev@oss.sgi.com, leonid.grossman@s2io.com,
       linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
Message-Id: <20040915135308.78bf74f0.davem@davemloft.net>
In-Reply-To: <1095275660.20569.0.camel@localhost.localdomain>
References: <4148991B.9050200@pobox.com>
	<Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
	<1095275660.20569.0.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 20:14:22 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2004-09-15 at 21:04, Paul Jakma wrote:
> > The intel IXP's are like the above, XScale+extra-bits host-on-a-PCI 
> > card running Linux. Or is that what you were referring to with 
> > "<cards exist> but they are all fairly expensive."?
> 
> Last time I checked 2Ghz accelerators for intel and AMD were quite cheap
> and also had the advantage they ran user mode code when idle from
> network processing.

ROFL, and this is my position on this topic as well.

There are absolutely no justified economics in these
TOE engines.  By the time you deploy them, the cpus
and memory catch up and what's more those are general
purpose and not just for networking as David Stevens
and others have said.

TOE is just junk, and we'll reject any attempt to put
that garbage into the kernel.
