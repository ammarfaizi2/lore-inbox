Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVC3STS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVC3STS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVC3STR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:19:17 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:23763
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262386AbVC3SQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:16:20 -0500
Date: Wed, 30 Mar 2005 10:15:26 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: dhowells@redhat.com, spyro@f2s.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
Message-Id: <20050330101526.3ac6de68.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503301317370.20171@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503292223090.18131@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com>
	<4243A257.8070805@yahoo.com.au>
	<20050325092312.4ae2bd32.davem@davemloft.net>
	<20050325162926.6d28448b.davem@davemloft.net>
	<22627.1112179577@redhat.com>
	<Pine.LNX.4.61.0503301317370.20171@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005 13:22:53 +0100 (BST)
Hugh Dickins <hugh@veritas.com> wrote:

> Sounds like we should leave flush_tlb_pgtables as it is
> (apart from the issue in its frv implementation that you noticed).

Ok.  I may still adjust the pmd_clear() args.
