Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWCVTTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWCVTTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWCVTTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:19:54 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2947 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932378AbWCVTTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:19:53 -0500
Date: Wed, 22 Mar 2006 11:20:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 13/35] Support loading an initrd when running on Xen
Message-ID: <20060322192008.GA15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063750.631016000@sorel.sous-sol.org> <200603221522.54661.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603221522.54661.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Wednesday 22 March 2006 07:30, Chris Wright wrote:
> > Due to the initial physical memory layout when booting on Xen, the initrd
> > image ends up below min_low_pfn (as registered with the bootstrap memory
> > allocator). Add an i386 build option to allow this scenario by setting
> > the initrd_below_start_ok flag.
> 
> Better would be to just handle that by default without any CONFIGs.

Indeed, thanks.
-chris
