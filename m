Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161562AbWHDWrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161562AbWHDWrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161563AbWHDWrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:47:17 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:24453 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1161562AbWHDWrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:47:16 -0400
Date: Fri, 4 Aug 2006 15:43:47 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Andi Kleen <ak@suse.de>
cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       James.Bottomley@steeleye.com, pazke@donpac.ru
Subject: Re: A proposal - binary
In-Reply-To: <200608050001.52535.ak@suse.de>
Message-ID: <Pine.LNX.4.63.0608041541200.18862@qynat.qvtvafvgr.pbz>
References: <44D1CC7D.4010600@vmware.com>  <20060804183448.GE11244@sequoia.sous-sol.org>
 <44D3B0F0.2010409@vmware.com> <200608050001.52535.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2006, Andi Kleen wrote:

> The problem with VMI is that while it allows hypervisor side evolution
> it doesn't really allow Linux side evolution with its fixed spec.
>
> But having it a bit isolated is probably ok.

actually, wouldn't something like this allow for a one-way evolution (the spec 
can be changed, but the hypervisor side needs to support clients what only talk 
older versions. i.e. the new spec is a superset of the old one (barring major 
security-type problems that require exeptions to the rules))?

David Lang
