Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUBUAfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUBUAfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:35:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58496 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261453AbUBUAfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:35:00 -0500
Date: Fri, 20 Feb 2004 16:34:57 -0800
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Fix silly thinko in sungem network driver.
Message-Id: <20040220163457.2ea387e5.davem@redhat.com>
In-Reply-To: <1077323090.10877.9.camel@gaston>
References: <200402202307.i1KN7GBR003938@hera.kernel.org>
	<1077321849.9719.32.camel@gaston>
	<1077322322.9623.34.camel@gaston>
	<20040220162318.097006ee.davem@redhat.com>
	<1077323090.10877.9.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Feb 2004 11:24:50 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Or did I get it backward ? Hrm, maybe I did... Here's Apple code:

This matches the current code, with Linus's fix applied.

> What does your doco says ?

It just says that all Sun versions of GEM support the IBURST bit.

It seems clear to me that the current code in Linus's tree is correct
and matches what Apple is doing.
