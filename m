Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVLCAWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVLCAWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVLCAWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:22:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:26591 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751093AbVLCAWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:22:35 -0500
Date: Fri, 2 Dec 2005 16:22:24 -0800
From: Greg KH <greg@kroah.com>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
Message-ID: <20051203002224.GB31077@kroah.com>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org> <20051201121826.GF19694@charite.de> <20051201211119.GA11437@hygelac> <Pine.LNX.4.64.0512011455090.3099@g5.osdl.org> <20051202180236.GA19327@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202180236.GA19327@hygelac>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 12:02:36PM -0600, Terence Ripperda wrote:
> On Thu, Dec 01, 2005 at 03:11:27PM -0800, torvalds@osdl.org wrote:
> > There's some explanation on what is going on in mm/memory.c: see the 
> > comments above the "vm_normal_page()" function (which you should never 
> > use: it's for internal VM usage, but it explains how the page range 
> > remapping works), and above "vm_insert_page()" (which you _should_ use).
> 
> Thanks Linus,
> 
> I didn't realize that the interface had changed. we're certainly happy
> to update our driver to use the appropriate interface.
> 
> the only problem is that it appears that vm_insert_page is exported
> GPL-only, which obviously creates problems.

Well, you were going to run into this problem eventually...

Good luck,

greg k-h
