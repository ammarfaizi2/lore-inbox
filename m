Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVCWT61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVCWT61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVCWT61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:58:27 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:26754
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262868AbVCWT6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:58:03 -0500
Date: Wed, 23 Mar 2005 11:57:36 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-Id: <20050323115736.300f34eb.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 17:10:15 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> Here's the recut of those patches, including David Miller's vital fixes.
> I'm addressing these to Nick rather than Andrew, because they're perhaps
> not fit for -mm until more testing done and the x86_64 32-bit vdso issue
> handled.  I'm unlikely to be responsive until next week, sorry: over to
> you, Nick - thanks.

Works perfectly fine on sparc64.

BTW, I note that we may still want something like that page table
bitmask stuff I worked on some time ago.  Ie. for things like
what lat_mmap does in lmbench, I think that situation is more
realistic than people might thing.
