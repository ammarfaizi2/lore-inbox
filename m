Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbUKTH1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbUKTH1M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbUKTH1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:27:12 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:20894
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262916AbUKTH1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:27:10 -0500
Date: Fri, 19 Nov 2004 23:11:00 -0800
From: "David S. Miller" <davem@davemloft.net>
To: James Morris <jmorris@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, ross.axe@blueyonder.co.uk, netdev@oss.sgi.com,
       sds@epoch.ncsc.mil, linux-kernel@vger.kernel.org, chrisw@osdl.org
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
Message-Id: <20041119231100.34b32431.davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0411191122470.10340-100000@thoron.boston.redhat.com>
References: <1100864358.8127.5.camel@localhost.localdomain>
	<Xine.LNX.4.44.0411191122470.10340-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004 11:24:03 -0500 (EST)
James Morris <jmorris@redhat.com> wrote:

> On Fri, 19 Nov 2004, Alan Cox wrote:
> 
> > Looks right to me, the ECONNRESET is no longer being lost.
> 
> Ok, here is a relative patch for Dave.
> 
> Please apply.
> 
> Signed-off-by: James Morris <jmorris@redhat.com>

Applied, thanks for fixing this up.
