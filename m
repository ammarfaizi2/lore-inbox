Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUFKFBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUFKFBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 01:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUFKFBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 01:01:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64203 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261793AbUFKFBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 01:01:31 -0400
Date: Thu, 10 Jun 2004 21:57:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: linux-kernel@vger.kernel.org, jmorris@redhat.com
Subject: Re: [PATCH] Fix Crypto digest.c kmapping sg entries > page in
 length
Message-Id: <20040610215712.0f91a40e.davem@redhat.com>
In-Reply-To: <yqujwu2jm74g.fsf@chaapala-lnx2.cisco.com>
References: <Xine.LNX.4.44.0406041921180.14838-100000@thoron.boston.redhat.com>
	<yqujwu2jm74g.fsf@chaapala-lnx2.cisco.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2004 15:43:27 -0500
Clay Haapala <chaapala@cisco.com> wrote:

> Below is the patch, against 2.6.7-rc2, to fix crypto/digest.c to do
> multiple kmap()/kunmap() for scatterlist entries which have a size
> greater than a single page, originally found and fixed by
> N.C.Krishna Murthy <krmurthy@cisco.com>.

Applied, thanks a lot Clay.
