Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266731AbUG0Xng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266731AbUG0Xng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266732AbUG0Xng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:43:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37787 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266731AbUG0Xne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:43:34 -0400
Date: Tue, 27 Jul 2004 16:41:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bh_lru_install
Message-Id: <20040727164147.39ad7f5c.davem@redhat.com>
In-Reply-To: <20040727160617.321ce504.akpm@osdl.org>
References: <20040723170338.0c9a38ef.davem@redhat.com>
	<20040727160617.321ce504.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 16:06:17 -0700
Andrew Morton <akpm@osdl.org> wrote:

> But I don't recall seeing bh_lru_install() standing out on profiles.  I
> expect that when the system is working hard we're averaging nearly zero
> cache misses in that copy.  Do you really think it is worth optimising?

On a full kernel build after a fresh boot, that memcpy() executes
approximately 400K times on my sparc64 boxes.
