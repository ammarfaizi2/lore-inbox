Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265740AbUGHD2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUGHD2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 23:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUGHD2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 23:28:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48817 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265740AbUGHD2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 23:28:05 -0400
Date: Wed, 7 Jul 2004 20:27:46 -0700
From: "David S. Miller" <davem@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: chrisw@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-Id: <20040707202746.1da0568b.davem@redhat.com>
In-Reply-To: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
References: <20040707122525.X1924@build.pdx.osdl.net>
	<E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jul 2004 13:12:41 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> What's wrong with using 0 as the NULL pointer? In contexts where
> a plain 0 is unsafe, NULL is usually unsafe as well.

It's a general sparse cleanup people are doing across the
entire tree.  It's the "proper" way to do pointer comparisons
post-K&R.
