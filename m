Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267179AbUHRCgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267179AbUHRCgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 22:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268583AbUHRCgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 22:36:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267179AbUHRCgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 22:36:46 -0400
Date: Tue, 17 Aug 2004 19:33:38 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jens Maurer <Jens.Maurer@gmx.net>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [PATCH] Use x86 SSE instructions for clear_page, copy_page
Message-Id: <20040817193338.16f57197.davem@redhat.com>
In-Reply-To: <41228946.5040207@gmx.net>
References: <4121A211.8080902@gmx.net>
	<1092727670.2792.4.camel@laptop.fenrus.com>
	<41228946.5040207@gmx.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 00:40:06 +0200
Jens Maurer <Jens.Maurer@gmx.net> wrote:

> What is a set of useful benchmarks to find out which approach
> is better?

Time kernel builds on an otherwise totally idle machine.
Do multiple runs so that the cache gets loaded and you're
testing the memory accesses rather than disk reads.
