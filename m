Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUIMAwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUIMAwS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 20:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUIMAwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 20:52:17 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:64927
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S264668AbUIMAwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 20:52:10 -0400
Date: Sun, 12 Sep 2004 17:50:41 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
Message-Id: <20040912175041.71fb385e.davem@davemloft.net>
In-Reply-To: <4144E93E.5030404@pobox.com>
References: <200409110726.i8B7QTGn009468@hera.kernel.org>
	<4144E93E.5030404@pobox.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004 20:26:38 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Dumb gcc attribute questions:
> 
> 1) what does force do? it doesn't appear to be in gcc 3.3.3 docs.
> 
> 2) is "volatile ... __force" redundant?
> 
> 3) can we use 'malloc' attribute on kmalloc?

Jeff, this code you quoted is in the sparse ifdef block.
