Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUHVFBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUHVFBT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUHVFBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:01:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43153 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266157AbUHVFBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:01:17 -0400
Date: Sat, 21 Aug 2004 22:00:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] use hlist for pid hash
Message-Id: <20040821220044.6974387d.davem@redhat.com>
In-Reply-To: <4128252E.1080002@yahoo.com.au>
References: <412824BE.4040801@yahoo.com.au>
	<4128252E.1080002@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004 14:46:38 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Any reason why this shouldn't be done? Anyone know of a decent test that
> stresses the pid hash?

I can't think of any way in which this could decrease
performance.  I highly recommend this patch :-)

