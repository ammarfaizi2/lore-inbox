Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161569AbWHDWwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161569AbWHDWwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161570AbWHDWwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:52:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53448 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161569AbWHDWws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:52:48 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: A proposal - binary
Date: Sat, 5 Aug 2006 00:52:36 +0200
User-Agent: KMail/1.9.3
Cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       James.Bottomley@steeleye.com, pazke@donpac.ru
References: <44D1CC7D.4010600@vmware.com> <200608050001.52535.ak@suse.de> <44D3CCA1.1040503@vmware.com>
In-Reply-To: <44D3CCA1.1040503@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608050052.36535.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For privileged domains that have hardware privileges and need to send 
> IPIs or something it might make sense. 

Any SMP guest needs IPI support of some sort.

But it is hopefully independent of subarchitectures in the paravirtualized
case.


> doesn't stop Linux from using the provided primitives in any way is 
> sees fit.  So it doesn't top evolution in that sense.  What it does stop 
> is having the Linux hypervisor interface grow antlers and have new 
> hooves grafted onto it.  What it sorely needed in the interface is a way 
> to probe 

That's the direction the interface is evolving I think (see multiple
entry point discussion) 

> and detect optional features that allow it to grow independent 
> of one particular hypervisor vendor.

Ok maybe not with options and subsets so far, but one has to
start somewhere.

-Andi
