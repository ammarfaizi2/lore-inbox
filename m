Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWHDAsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWHDAsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWHDAsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:48:11 -0400
Received: from mx1.suse.de ([195.135.220.2]:39872 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932570AbWHDAsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:48:10 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Date: Fri, 4 Aug 2006 02:47:59 +0200
User-Agent: KMail/1.9.3
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
References: <20060803002510.634721860@xensource.com> <200608030802.44391.ak@suse.de> <Pine.LNX.4.64.0608030943110.29745@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608030943110.29745@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608040247.59950.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> An include <asm/xen-bitops.h> would need to fall back to asm-generic if
> there is no file in asm-arch/xen-bitops.h. I thought we had such a 
> mechanism?

AFAIK not. If you want generic you need a proxy include file.

-Andi
