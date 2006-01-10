Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWAJMtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWAJMtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWAJMtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:49:42 -0500
Received: from ns2.suse.de ([195.135.220.15]:35548 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750810AbWAJMtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:49:41 -0500
From: Andi Kleen <ak@suse.de>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add
Date: Tue, 10 Jan 2006 13:48:16 +0100
User-Agent: KMail/1.8
Cc: keith <kmannth@us.ibm.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Matt Tolentino <metolent@cs.vt.edu>, akpm@osdl.org, discuss@x86-64.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1136837348.31043.105.camel@knk> <20060110201604.38B0.Y-GOTO@jp.fujitsu.com> <20060110214140.38B2.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060110214140.38B2.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101348.17322.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 13:43, Yasunori Goto wrote:
> > IIRC, SRAT is just for booting time. So, when hotplug occured,
> > it is not reliable. DSDT should be used for it in order to SRAT
> > like following 2 patches.
> > First is to get pxm from physical address.
> > I'll post the second patch after this post.
>
> Second one is here.
> This is map/unmap between pxm to nid. This is just for ia64.
> But I guess for x86-64 is not so difference.

It probably is. The x86-64 NUMA setup is quite different from IA64.

-Andi
