Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265947AbUGIUDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUGIUDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUGIUDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:03:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34445 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265947AbUGIUCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:02:35 -0400
Date: Fri, 9 Jul 2004 13:01:58 -0700
From: "David S. Miller" <davem@redhat.com>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Message-Id: <20040709130158.3a3cd556.davem@redhat.com>
In-Reply-To: <20040709194753.GB11138@wavehammer.waldi.eu.org>
References: <20040709140630.GA27350@wavehammer.waldi.eu.org>
	<20040709120336.74e57ceb.akpm@osdl.org>
	<20040709192253.GA11138@wavehammer.waldi.eu.org>
	<20040709123005.086fdfc5.davem@redhat.com>
	<20040709194753.GB11138@wavehammer.waldi.eu.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2004 21:47:53 +0200
Bastian Blank <bastian@waldi.eu.org> wrote:

> On Fri, Jul 09, 2004 at 12:30:05PM -0700, David S. Miller wrote:
> > On Fri, 9 Jul 2004 21:22:53 +0200
> > Bastian Blank <bastian@waldi.eu.org> wrote:
> > 
> > > The original submission is recorded on
> > > http://marc.theaimsgroup.com/?l=linux-net&m=104551077013011&w=2. And the
> > > complaint was that it puts '"ipv6 stuff" into the generic netdevice
> > > structure'. I don't know if this can be solved another way.
> > 
> > Put it in the inet6device private area.
> 
> Where is it declared?

struct inet6_dev is declared in include/net/if_inet6.h

I used grep to discover how the ipv6 device provate information
is managed, you could have as well :-)  I didn't know any of this
stuff offhand, I had to look it up.
