Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbULXSAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbULXSAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbULXSAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:00:32 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:39644
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261239AbULXSAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:00:30 -0500
Date: Fri, 24 Dec 2004 10:00:16 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [1/4]
Message-Id: <20041224100016.530a004c.davem@davemloft.net>
In-Reply-To: <20041224173519.GB13747@dualathlon.random>
References: <20041224173519.GB13747@dualathlon.random>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 18:35:19 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

> I made used_math a char at the light of later patches. per-cpu atomicity
> with byte granularity is provided by all archs AFIK.

Older Alpha's need to read-modify-write a word to implement
byte ops.
