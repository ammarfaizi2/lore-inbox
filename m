Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUL1SKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUL1SKD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 13:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUL1SKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 13:10:03 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:29870
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261207AbUL1SJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 13:09:59 -0500
Date: Tue, 28 Dec 2004 10:05:07 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bunk@stusta.de, ralf@linux-mips.org, linux-hams@vger.kernel.org,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] /net/ax25/: some cleanups
Message-Id: <20041228100507.7b374b5e.davem@davemloft.net>
In-Reply-To: <1104237408.20944.70.camel@localhost.localdomain>
References: <20041212211339.GX22324@stusta.de>
	<20041227185151.2a7ceb71.davem@davemloft.net>
	<1104237408.20944.70.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 14:27:08 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2004-12-28 at 02:51, David S. Miller wrote:
> > On Sun, 12 Dec 2004 22:13:39 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > The patch below contains the following cleanups:
> > > - make two needlessly global functions static
> > > - net/ax25/ax25_addr.c: remove the unused global function ax25digicmp
> 
> Dave this function is only unused because a patch in 2.6.10 broke AX.25
> protocol support by removing the device and path checks. AX.25 is a link
> layer protocol it is supposed to check the devices and arguably the
> path. 

Send a patch to netdev and CC: me to fix this as is standard
procedure for getting changes into the networking.  :-)


