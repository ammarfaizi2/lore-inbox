Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUF0V1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUF0V1n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 17:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUF0V1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 17:27:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38870 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263827AbUF0V1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 17:27:41 -0400
Date: Sun, 27 Jun 2004 14:26:28 -0700
From: "David S. Miller" <davem@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040627142628.34b60c82.davem@redhat.com>
In-Reply-To: <200406271242.22490.oliver@neukum.org>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<200406270631.41102.oliver@neukum.org>
	<20040626233423.7d4c1189.davem@redhat.com>
	<200406271242.22490.oliver@neukum.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004 12:42:21 +0200
Oliver Neukum <oliver@neukum.org> wrote:

> OK, then it shouldn't be used in this case. However, shouldn't we have
> an attribute like __nopadding__ which does exactly that?

It would have the same effect.  CPU structure layout rules don't pack
(or using other words, add padding) exactly in cases where it is
needed to obtain the necessary alignment.
