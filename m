Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVCNWhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVCNWhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVCNWhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:37:39 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:18350
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262043AbVCNWgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:36:08 -0500
Date: Mon, 14 Mar 2005 14:34:42 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: bad pgd/pmd in latest BK on ia64
Message-Id: <20050314143442.2ab086c9.davem@davemloft.net>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F031272AF@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F031272AF@scsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 14:06:09 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> Trying to boot a build of the latest BK on ia64 I see
> a series of messages like this:
> 
> mm/memory.c:99: bad pgd e0000001feba4000.
> mm/memory.c:99: bad pgd e0000001febac000.
> mm/memory.c:99: bad pgd e0000001febc0d10.

Things are similarly busted on sparc64 for me as well.
Things instantly reboot right after the kernel tries
to open an initial console.
