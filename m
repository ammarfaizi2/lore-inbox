Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUGAF0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUGAF0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 01:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUGAF0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 01:26:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46047 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263972AbUGAF0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 01:26:42 -0400
Date: Wed, 30 Jun 2004 22:25:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: jakub@redhat.com, wesolows@foobazco.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040630222547.65d793da.davem@redhat.com>
In-Reply-To: <20040630225220.GA32560@mail.shareable.org>
References: <20040630030503.GA25149@mail.shareable.org>
	<20040630082804.GS21264@devserv.devel.redhat.com>
	<20040630135419.25b843b8.davem@redhat.com>
	<20040630225220.GA32560@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 23:52:20 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> The PaX security patch already implements R!X pages on Sparc64, so you
> could just cut out that part of the patch.  Just pick out the changes
> to arch/sparc64/* and include/asm-sparc64/*:
> 
> 	http://pax.grsecurity.net/pax-linux-2.6.7-200406252135.patch
> 
> It appears to use exactly the technique Jakub describes, and has been tested.

Great, I'm integrating something along these lines right now.

Do you have any idea who authored the sparc64 bits so I can give
them credit?
