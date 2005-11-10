Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbVKJByP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVKJByP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVKJByP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:54:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:33458 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751415AbVKJByO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:54:14 -0500
Subject: Re: [PATCH 06/15] mm: remove ppc highpte
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511100148410.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0511100148410.5814@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 12:52:22 +1100
Message-Id: <1131587542.24637.134.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 01:50 +0000, Hugh Dickins wrote:
> ppc's HIGHPTE config option was removed in 2.5.28, and nobody seems to
> have wanted it enough to restore it: so remove its traces from pgtable.h
> and pte_alloc_one.  Or supply an alternative patch to config it back?

Hrm... ppc32 does have fully working kmap & kmap atomic so I would
rather put back the CONFIG option...

Ben.


