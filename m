Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263275AbVCDXw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbVCDXw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263332AbVCDXuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:50:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:18859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263337AbVCDWjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:39:53 -0500
Date: Fri, 4 Mar 2005 14:39:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm1
Message-Id: <20050304143947.4e1e1bc2.akpm@osdl.org>
In-Reply-To: <1109974593.9696.11.camel@boxen>
References: <20050304033215.1ffa8fec.akpm@osdl.org>
	<1109974593.9696.11.camel@boxen>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> wrote:
>
> fre 2005-03-04 klockan 03:32 -0800 skrev Andrew Morton:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/
> > 
> > 
> > - Added the new bk-audit tree.  Contains updates to the kernel's audit
> >   feature.  Maintained by David Woodhouse.
> > 
> > - The Dell keyboard problems should be fixed.  Testing needed.
> > 
> > - Dmitry's bk-dtor-input tree is no longer active and has been dropped.
> 
> Just booted up a box and tried to log onto ssh which didn't worked so I
> looked at kernel log and behold, 128MB box with no swap, had just
> booted. Couldn't get any access after this.
> A few kernel debugging options were chosen notably CONFIG_DEBUG_SLAB &
> CONFIG_DEBUG_PAGEALLOC

So you're saying that the box has run out of memory?

Please send me the .config then disable CONFIG_DEBUG_PAGEALLOC and retest,
thanks.

