Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUHDTZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUHDTZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUHDTZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:25:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267391AbUHDTZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:25:34 -0400
Date: Wed, 4 Aug 2004 12:22:54 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: ak@muc.de, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-Id: <20040804122254.3d52c2d4.davem@redhat.com>
In-Reply-To: <20040804191850.GA19224@havoc.gtf.org>
References: <2ppN4-1wi-11@gated-at.bofh.it>
	<2pvps-5xO-33@gated-at.bofh.it>
	<2pvz2-5Lf-19@gated-at.bofh.it>
	<2pwbQ-68b-43@gated-at.bofh.it>
	<m33c32ke3f.fsf@averell.firstfloor.org>
	<20040804191850.GA19224@havoc.gtf.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004 15:18:50 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> On Wed, Aug 04, 2004 at 07:28:04PM +0200, Andi Kleen wrote:
> > So please never pass any structures with read/write/netlink.
> 
> Sorry...  This is pretty much a given IMO.

Yes, netlink would be a nop if we gave in to Andi's reccomendation
:-)
