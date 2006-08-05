Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWHEKrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWHEKrk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 06:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWHEKrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 06:47:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58638 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751439AbWHEKrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 06:47:39 -0400
Date: Sat, 5 Aug 2006 12:47:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       James.Bottomley@steeleye.com, pazke@donpac.ru
Subject: Re: A proposal - binary
Message-ID: <20060805104735.GS25692@stusta.de>
References: <44D1CC7D.4010600@vmware.com> <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com> <200608050001.52535.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608050001.52535.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 12:01:52AM +0200, Andi Kleen wrote:
> 
> There is no reason Summit or es7000 or any other subarchitecture 
> would need to do different  virtualization. In fact these subarchitectures 
> are pretty much obsolete by the generic subarchitecture and could be fully
> done by runtime switching.
>...

Has anyone measured the performance impact of rutime CLOCK_TICK_RATE 
switching (since this will no longer allow some compile time 
optimizations in jiffies.h)?

> -Andi

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

