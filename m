Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263452AbVCEAgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbVCEAgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbVCEAHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:07:02 -0500
Received: from waste.org ([216.27.176.166]:43437 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263266AbVCDWFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:05:17 -0500
Date: Fri, 4 Mar 2005 14:05:08 -0800
From: Matt Mackall <mpm@selenic.com>
To: Richard Fuchs <richard.fuchs@inode.info>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
Message-ID: <20050304220508.GA3120@waste.org>
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <20050304201153.GR3163@waste.org> <4228D0D9.9010301@inode.info> <20050304212730.GZ3120@waste.org> <4228D8A6.3080402@inode.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228D8A6.3080402@inode.info>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:52:38PM +0100, Richard Fuchs wrote:
> Matt Mackall wrote:
> 
> >Doh. 'ethtool -k' is what's needed, sorry.
> 
> doh myself. :) this won't be very helpful though, as i get the same on 
> all machines (with both drivers):
> 
> Offload parameters for eth0:
> Cannot get device rx csum settings: Operation not supported
> Cannot get device tx csum settings: Operation not supported
> Cannot get device scatter-gather settings: Operation not supported
> Cannot get device tcp segmentation offload settings: Operation not supported
> no offload info available

Which card/driver is this? Is this the same card that's showing ssh
troubles? My theory about your ssh trouble only applies to cards with
checksum offload.

-- 
Mathematics is the supreme nostalgia of our time.
