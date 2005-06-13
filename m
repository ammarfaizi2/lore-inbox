Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVFMVto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVFMVto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVFMVtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:49:36 -0400
Received: from colin.muc.de ([193.149.48.1]:63505 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261446AbVFMVsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:48:25 -0400
Date: 13 Jun 2005 23:48:21 +0200
Date: Mon, 13 Jun 2005 23:48:21 +0200
From: Andi Kleen <ak@muc.de>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Tracking a bug in x86-64
Message-ID: <20050613214821.GD86745@muc.de>
References: <200506132259.22151.bonganilinux@mweb.co.za> <200506132339.13614.bonganilinux@mweb.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506132339.13614.bonganilinux@mweb.co.za>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 11:39:13PM +0200, Bongani Hlope wrote:
> On Monday 13 June 2005 10:59 pm, Bongani Hlope wrote:
> > Hi Andrew and Andi
> > 
> > I've been trying to track dow an bug that causes my userspace applications to 
> > randomly segfault. I've tracked it down to 2.6.11-mm4 (I'm not sure about mm[1-3]).  
> > The bug does not exist in the 2.6.11 kernel. The 2.6.12-rc1 kernel has the bug. The bug 
> > is easly triggered by compiling KDE or the kernel using make -j4
> > 
> 
> I've just tested 2.6.11-mm1 it has that bug as well. So the bug was introduced on that kernel.

Can you please get the individual patches from -mm1 and test them?
I would just unapply the various x86-64 patches and do a binary search.

Thanks,

-Andi
