Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUJETyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUJETyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUJETyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:54:01 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:15752
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266034AbUJETxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:53:21 -0400
Date: Tue, 5 Oct 2004 12:53:00 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] 2.[46]: Set ARP hw type correctly for BOOTP over
 FDDI
Message-Id: <20041005125300.106abab9.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58L.0410040310550.22545@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.58L.0410040310550.22545@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004 23:56:59 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  Using the Ethernet ARP hw type for FDDI networks is mandated by RFC 1390
> (STD 36) and that code is already used by Linux elsewhere, but not for
> BOOTP requests sent for IPv4 autoconfiguration.  Here is a patch for both
> 2.4 and 2.6 that fixes the problem for me.  Please apply.
> 
>  Applies both to 2.4.27 and to 2.6.8.1.

Patch applied, thanks.
