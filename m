Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270851AbUJVEdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270851AbUJVEdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270913AbUJUTp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:45:58 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:32171
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S270904AbUJUTkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:40:02 -0400
Date: Thu, 21 Oct 2004 12:34:04 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-ac2
Message-Id: <20041021123404.1d947ee0.davem@davemloft.net>
In-Reply-To: <1098379853.17095.160.camel@localhost.localdomain>
References: <1098379853.17095.160.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 18:30:54 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> o	Set VM_IO on areas that are temporarily		(Alan Cox)
> 	marked PageReserved (Serious bug)

2.4.x will need this one as well, at least the AF_PACKET
case.  Would you mind if I pushed that to Marcelo?
