Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWAMAFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWAMAFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWAMAFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:05:19 -0500
Received: from ns1.coraid.com ([65.14.39.133]:39634 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751492AbWAMAFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:05:18 -0500
Date: Thu, 12 Jan 2006 18:55:34 -0500
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg K-H <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/block/aoe/aoecmd.c: make aoecmd_cfg_pkts() static
Message-ID: <20060112235534.GB6169@coraid.com>
References: <20060111042135.24faf878.akpm@osdl.org> <20060112104833.GS29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112104833.GS29663@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 11:48:33AM +0100, Adrian Bunk wrote:

...
> aoecmd_cfg_pkts() can be static.

Nice catch.  This patch follows a series of seven aoe driver patches
that haven't made it into the mainline because they need a fix that
I've just made.

I'll be resending the patches with the fix included, and at that time
I'll include this change.

Thanks!

-- 
  Ed L Cashin <ecashin@coraid.com>
