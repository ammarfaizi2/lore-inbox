Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVCWTWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVCWTWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVCWTWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:22:03 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:60821
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262792AbVCWTVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:21:54 -0500
Date: Wed, 23 Mar 2005 11:19:55 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hugh@veritas.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
Message-Id: <20050323111955.728f03d5.davem@davemloft.net>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0324516D@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0324516D@scsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 11:16:27 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> Can we legislate that "end==0" isn't possible.

It is possible with some out-of-tree patches.

I could certainly support it on sparc64, the only
glitch is that this is where the virtually mapped
linear page tables sit right now :-)
