Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVB1Xxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVB1Xxq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVB1Xxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:53:45 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:57027
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261825AbVB1Xxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:53:39 -0500
Date: Mon, 28 Feb 2005 15:51:42 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org, ultralinux@vger.kernel.org
Subject: Re: SPARC64: Modular floppy?
Message-Id: <20050228155142.12ae31a7.davem@davemloft.net>
In-Reply-To: <200502282007.j1SK7hgE031074@laptop11.inf.utfsm.cl>
References: <200502282007.j1SK7hgE031074@laptop11.inf.utfsm.cl>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005 17:07:43 -0300
Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

> So, either the dependencies have to get fixed so floppy can't be modular
> for this architecture, or the relevant functions have to move from entry.S
> to the module.

I think the former is the best solution.  The assembler code really
needs to get at floppy.c symbols.
