Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUHOWCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUHOWCA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267171AbUHOWCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:02:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4076 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267165AbUHOWB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:01:58 -0400
Date: Sun, 15 Aug 2004 14:59:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: a5497108@anet.ne.jp, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27
Message-Id: <20040815145952.1f573264.davem@redhat.com>
In-Reply-To: <20040815195758.GE9500@logos.cnet>
References: <200408150152.EAC63479.8815296B@anet.ne.jp>
	<20040815195758.GE9500@logos.cnet>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004 16:57:58 -0300
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> On Sun, Aug 15, 2004 at 01:53:49AM +0900, Tetsuo Handa wrote:
> > Hello,
> > 
> > I'm using tg3.o with DHCP and PXE boot environment
> > and I updated from 2.4.26 to 2.4.27,
> > but tg3.o became not working with IBM BladeCenter.
> > 
> > I think tg3.o in 2.4.27 is generating something broken arp.
> > When I run 'arp' in the DHCP server (who doesn't use tg3.o),
> > the entry with <incomplete> status appears.
> > The IP address which has the <incomplete> status is
> > the DHCP client's (who is using tg3.o in 2.4.27).
> > 
> > The workaround I took is to replace tg3.h and tg3.c
> > in 2.4.27 with the files in 2.4.26, and it seems working fine.
> 
> David Miller is the tg3 maintainer, he will help you.

Does manual IP configuration work?
