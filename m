Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWCXMN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWCXMN1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWCXMN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:13:27 -0500
Received: from cantor2.suse.de ([195.135.220.15]:27067 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932597AbWCXMN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:13:27 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] use select for GART_IOMMU to enable AGP
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323175822.GA7816@redhat.com>
	<20060323133741.21a72249.akpm@osdl.org>
	<Pine.LNX.4.64.0603241233530.16802@scrub.home>
From: Andi Kleen <ak@suse.de>
Date: 24 Mar 2006 13:13:22 +0100
In-Reply-To: <Pine.LNX.4.64.0603241233530.16802@scrub.home>
Message-ID: <p73odzw59ct.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

> The easiest solution is to simply remove the default and let GART_IOMMU 
> select AGP too.

GART_IOMMU works without AGP driver too. It just has the requirement
that the AMD64 AGP driver is either builtin or not enabled at all.

-Andi
