Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVCGGKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVCGGKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 01:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVCGGKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 01:10:38 -0500
Received: from 64-85-47-3.ip.van.radiant.net ([64.85.47.3]:2571 "EHLO
	vlinkmail") by vger.kernel.org with ESMTP id S261639AbVCGGK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 01:10:26 -0500
Date: Sat, 5 Mar 2005 22:23:20 -0800
From: Greg KH <greg@kroah.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/5] setup_per_zone_lowmem_reserve() oops fix
Message-ID: <20050306062320.GA13188@kroah.com>
References: <200503042117.j24LHGrx017967@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503042117.j24LHGrx017967@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:16:55PM -0800, akpm@osdl.org wrote:
> 
> 
> If you do 'echo 0 0 > /proc/sys/vm/lowmem_reserve_ratio' the kernel gets a
> divide-by-zero.
> 
> Prevent that, and fiddle with some whitespace too.

Due to the whitespace fiddling, I'd say no to this patch, based on the
"criteria".

thanks,

greg k-h
