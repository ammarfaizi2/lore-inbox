Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030722AbWKORLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030722AbWKORLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030718AbWKORLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:11:20 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18101
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030723AbWKORLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:11:19 -0500
Message-Id: <455B5892.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 17:12:34 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <patches@x86-64.org>
Subject: Re: [PATCH] x86-64: adjust pmd_bad()
References: <455B3AF2.76E4.0078.0@novell.com>
 <Pine.LNX.4.64.0611151658520.24160@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0611151658520.24160@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Hugh Dickins <hugh@veritas.com> 15.11.06 18:01 >>>
>On Wed, 15 Nov 2006, Jan Beulich wrote:
>
>> Make pmd_bad() symmetrical to pgd_bad() and pud_bad(). At once,
>> simplify them all.
>
>Symmetrical and simpler, yes, but you're weakening the pmd_bad() test:
>no longer requires that all those _KERNPG_TABLE bits be set.  Wouldn't
>it be better to go the other way and strengthen pgd_bad, pud_bad?

Maybe, but there must have been a reason for not doing so. It could
certainly be a follow-up patch - if it works.

Jan
