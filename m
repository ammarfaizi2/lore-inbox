Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUHWElW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUHWElW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 00:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267383AbUHWElW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 00:41:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43175 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267354AbUHWElU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 00:41:20 -0400
Date: Sun, 22 Aug 2004 21:40:40 -0700
From: "David S. Miller" <davem@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: zwane@linuxpower.ca, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ak@suse.de, wli@holomorphy.com
Subject: Re: [PATCH][1/4] Completely out of line spinlocks / i386
Message-Id: <20040822214040.4c866da2.davem@redhat.com>
In-Reply-To: <22241.1093220988@ocs3.ocs.com.au>
References: <Pine.LNX.4.58.0408221740090.27390@montezuma.fsmlabs.com>
	<22241.1093220988@ocs3.ocs.com.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004 10:29:48 +1000
Keith Owens <kaos@ocs.com.au> wrote:

> I find that the decoding the lock is useful but not required,
> the function that contended on the lock is more interesting.

This is my belief as well.
