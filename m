Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVCAXGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVCAXGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVCAXGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:06:42 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:38629
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262078AbVCAXGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:06:40 -0500
Date: Tue, 1 Mar 2005 15:04:13 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org,
       ultralinux@vger.kernel.org
Subject: Re: SPARC64: Modular floppy?
Message-Id: <20050301150413.31d0b533.davem@davemloft.net>
In-Reply-To: <200503011926.j21JQ5dP007149@laptop11.inf.utfsm.cl>
References: <4224A592.1050909@osdl.org>
	<200503011926.j21JQ5dP007149@laptop11.inf.utfsm.cl>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Mar 2005 16:26:05 -0300
Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

> Right. But where? I was thinking under arch/sparc64/drivers/floppy.S or
> such. And then there would need to be some make magic for it to get picked
> up and included only for sparc64. Sounds doable, if somewhat messy.

Sparc 32-bit has the same problem btw.  It's a direct IRQ handler that
doesn't need to save any trap state.
