Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265118AbUF1S1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUF1S1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUF1S07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:26:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265117AbUF1S0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:26:40 -0400
Date: Mon, 28 Jun 2004 11:25:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: kiocb->private is too large for kiocb's on-stack
Message-Id: <20040628112510.509d08f7.davem@redhat.com>
In-Reply-To: <20040628082016.GP21066@holomorphy.com>
References: <20040628080801.GO21066@holomorphy.com>
	<20040628011232.43acd3b8.akpm@osdl.org>
	<20040628082016.GP21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 01:20:16 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Mon, Jun 28, 2004 at 01:12:32AM -0700, Andrew Morton wrote:
> > That's so much better than what we had before it ain't funny.
> > Was this runtime tested?
> 
> Yes. Oracle exercises this, and it survives OAST.
> 
> I'll write a dedicated userspace testcase for the aio operations and
> follow up with that.

This all looks fine to me.  Andrew, would you like me to push this
patch along or did you already plan to take care of it.

Nice work William.
