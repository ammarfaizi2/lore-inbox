Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUDNV1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUDNV1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:27:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:1668 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261735AbUDNV1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:27:42 -0400
Date: Wed, 14 Apr 2004 14:27:24 -0700
From: Greg KH <greg@kroah.com>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [SECURITY] CAN-2004-0075 (was: Re: [SECURITY] CAN-2004-0109 isofs fix.)
Message-ID: <20040414212724.GA24809@kroah.com>
References: <20040414171147.GB23419@redhat.com> <200404142230.33553@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404142230.33553@WOLK>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 10:30:33PM +0200, Marc-Christian Petersen wrote:
> On Wednesday 14 April 2004 19:11, Dave Jones wrote:
> 
> Hi,
> 
> > Merged in 2.4, and various vendor kernels today..
> 
> Okay, now while we are at fixing security holes, is there any chance we 
> can _finally_ get the attached patch in?
> 
> The Vicam USB driver in all Linux Kernels 2.6 mainline does not use the 
> copy_from_user function when copying data from userspace to kernel space, 
> which crosses security boundaries and allows local users to cause a denial
> of service.
> 
> Already ACKed by Greg. Only complaint was inproper coding style which is done 
> with attached patch ;)

Eeek, I thought this one was already in the tree, very sorry about that.

I'm applying it now and will send it to Linus in a bit.

thanks for reminding me,

greg k-h
