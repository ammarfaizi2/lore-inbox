Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265964AbUGIUIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUGIUIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUGIUG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:06:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265964AbUGIUGd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:06:33 -0400
Date: Fri, 9 Jul 2004 13:05:53 -0700
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: bastian@waldi.eu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Message-Id: <20040709130553.223bdc6b.davem@redhat.com>
In-Reply-To: <20040710.045904.106621629.yoshfuji@linux-ipv6.org>
References: <20040709120336.74e57ceb.akpm@osdl.org>
	<20040709192253.GA11138@wavehammer.waldi.eu.org>
	<20040709123005.086fdfc5.davem@redhat.com>
	<20040710.045904.106621629.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2004 04:59:04 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> David, inet6device area is created when we create first address.

We could change the ipv6 layer to allocate the private
layer much earlier.
