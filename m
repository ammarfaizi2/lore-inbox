Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVD3XDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVD3XDK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 19:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVD3XDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 19:03:10 -0400
Received: from fsmlabs.com ([168.103.115.128]:8085 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261275AbVD3XDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 19:03:06 -0400
Date: Sat, 30 Apr 2005 17:05:43 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ed Tomlinson <tomlins@cam.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
In-Reply-To: <200504301853.40395.tomlins@cam.org>
Message-ID: <Pine.LNX.4.61.0504301700470.3559@montezuma.fsmlabs.com>
References: <20050429231653.32d2f091.akpm@osdl.org> <200504300827.44359.tomlins@cam.org>
 <Pine.LNX.4.61.0504301634590.3559@montezuma.fsmlabs.com>
 <200504301853.40395.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005, Ed Tomlinson wrote:

> Huh?  Assuming one already has a current git tree.  Then all Andrew need do
> is publish the commit id from Linus then the complicated procedure becomes
> 
> cd <checkedout git copy of kernel>
> cg-update origin
> cg-export ../<work dir> <commit id>
> cd ../<work dir>
> cp ../<default config> .config
> bzcat ../<mm patch> | patch -p1
> make oldconfig
> make
> 
> No problem to script this at all.  Also, I suspect what when tagging starts to be 
> used, that <commit id> will be an easily typeable string.

Ok, now tell this to one of the users who tests kernels, now users also 
need to know how to use git in order to test -mm. I'm thinking about the 
case where someone reports a bug on LKML and we ask that they test latest 
-mm, getting them to also understand git just to quickly test something is 
silly. Also people tend to have other things to do so making things 
even slightly more difficult doesn't win you testers. Maybe i'm just 
lazy... *shrug*
