Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWC2Wx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWC2Wx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWC2Wxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:53:33 -0500
Received: from cantor2.suse.de ([195.135.220.15]:1516 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751177AbWC2Wxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:53:30 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: dcache leak in 2.6.16-git8 II
Date: Thu, 30 Mar 2006 00:53:24 +0200
User-Agent: KMail/1.9.1
Cc: bharata@in.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <200603270750.28174.ak@suse.de> <200603300026.59131.ak@suse.de> <20060329145013.37c87323.akpm@osdl.org>
In-Reply-To: <20060329145013.37c87323.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603300053.25235.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 00:50, Andrew Morton wrote:

> It looks that way.  Didn't someone else report a sock_inode_cache leak?

Didn't see it.
 
> > I still got a copy of the /proc in case anybody wants more information.
> 
> We have this fancy new /proc/slab_allocators now, it might show something
> interesting.  It needs CONFIG_DEBUG_SLAB_LEAK.

I didn't have that enabled unfortunately. I can try it on the next round.

-Andi

