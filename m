Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422762AbWCXMpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762AbWCXMpP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbWCXMpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:45:15 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:22672 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1422762AbWCXMpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:45:13 -0500
Date: Fri, 24 Mar 2006 13:45:00 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] use select for GART_IOMMU to enable AGP
In-Reply-To: <p73odzw59ct.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.64.0603241335140.16802@scrub.home>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <20060323175822.GA7816@redhat.com>
 <20060323133741.21a72249.akpm@osdl.org> <Pine.LNX.4.64.0603241233530.16802@scrub.home>
 <p73odzw59ct.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 24 Mar 2006, Andi Kleen wrote:

> > The easiest solution is to simply remove the default and let GART_IOMMU 
> > select AGP too.
> 
> GART_IOMMU works without AGP driver too. It just has the requirement
> that the AMD64 AGP driver is either builtin or not enabled at all.

I don't see how this is/was possible, if GART_IOMMU was enabled so was AGP 
(and AGP_AMD64). That hasn't changed with the patch.

bye, Roman
