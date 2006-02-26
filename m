Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWBZWnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWBZWnN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWBZWnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:43:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30984 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751412AbWBZWnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:43:12 -0500
Date: Sun, 26 Feb 2006 23:43:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Message-ID: <20060226224300.GA8835@mars.ravnborg.org>
References: <200602261721.17373.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602261721.17373.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 05:21:17PM +0100, Jesper Juhl wrote:
> 
> Hi everyone,
> 
> I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)
> 
> 	95 kernels were build with 'make randconfig'.
> 	1 kernel was build with the config I normally use for my own box.
> 	1 kernel was build from 'make defconfig'.
> 	1 kernel was build from 'make allmodconfig'.
> 	1 kernel was build from 'make allnoconfig'.
> 	1 kernel was build from 'make allyesconfig'.
> 
> That was an interresting experience. 
> 
> First of all not very many of the kernels actually build correctly and 
> secondly, if I grep the build logs for warnings I'm swamped.
> 
> Out of 100 kernels 82 failed to build - that's an 18% success rate people, 
> not very impressive.
I would recommed to fix the obvious cases and leave it.
Better to concentrate on 'normal' configs. This includes
allmodconfig/allyesconfig/defconfig but it certainly does not include a
bunch of random configs. Real peoples config is much better for this.

	Sam
