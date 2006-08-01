Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWHAVub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWHAVub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWHAVub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:50:31 -0400
Received: from ns2.suse.de ([195.135.220.15]:23256 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751060AbWHAVua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:50:30 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 10 of 13] Change pte_clear_full to a more appropriately named pte_clear_not_present,
Date: Tue, 1 Aug 2006 23:48:35 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, Andrew Morton <akpm@osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <553154516a1b008a1e63.1154462448@ezr>
In-Reply-To: <553154516a1b008a1e63.1154462448@ezr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608012348.35175.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -#ifndef __HAVE_ARCH_PTE_CLEAR_FULL
> -#define pte_clear_full(__mm, __address, __ptep, __full)			\
> +#ifndef __HAVE_ARCH_PTE_CLEAR_NOT_PRESENT_FULL
> +#define pte_clear_not_present_full(__mm, __address, __ptep, __full)	\
>  do {									\
>  	pte_clear((__mm), (__address), (__ptep));			\
>  } while (0)

Needs comments I guess

-Andi
