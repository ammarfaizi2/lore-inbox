Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUB1Hrb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 02:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbUB1Hrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 02:47:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54957 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262984AbUB1Hra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 02:47:30 -0500
Date: Fri, 27 Feb 2004 23:44:19 -0800
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [patch] u64 casts
Message-Id: <20040227234419.7cee9b29.davem@redhat.com>
In-Reply-To: <16447.58524.257563.252138@napali.hpl.hp.com>
References: <1077915522.2255.28.camel@cube>
	<16447.56941.774257.925722@napali.hpl.hp.com>
	<1077920213.2233.44.camel@cube>
	<16447.58524.257563.252138@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 16:45:16 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> >>>>> On 27 Feb 2004 17:16:53 -0500, Albert Cahalan <albert@users.sourceforge.net> said:
> 
>   Albert> Supposing that this is the case, you may get warnings.
> 
> Well, then do it on your own kernel/system.  I'm not interested in
> spending time on this now, so please don't touch ia64 unless you
> verified that all the other pieces are in place.

Yes, and I already know that trying to do things this way results
in more warnings and more problems on sparc64, as I've tried it.

