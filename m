Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVCWCmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVCWCmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVCWCmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:42:23 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:43689
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262725AbVCWCRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:17:18 -0500
Date: Tue, 22 Mar 2005 18:15:36 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, hugh@veritas.com, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322181536.7c60c545.davem@davemloft.net>
In-Reply-To: <4240D022.1020202@yahoo.com.au>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03211851@scsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.61.0503230052500.10858@goblin.wat.veritas.com>
	<20050322171013.5c52dd18.akpm@osdl.org>
	<20050322180020.7ce75c30.davem@davemloft.net>
	<4240D022.1020202@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 13:10:42 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> The ugly thing you get with an inclusive ceiling is that your masking
> becomes more difficult I think.

Good point.

> I might try to attack this from another angle and see if I can come up
> with something.

Great, let me know if you want something tested out on sparc64.
