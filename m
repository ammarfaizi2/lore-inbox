Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267967AbUHEUvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbUHEUvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267970AbUHEUuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:50:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9096 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267966AbUHEUtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:49:24 -0400
Date: Thu, 5 Aug 2004 16:49:20 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
In-Reply-To: <411299D4.5060001@tmr.com>
Message-ID: <Pine.LNX.4.44.0408051647440.8229-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Bill Davidsen wrote:
> Rik van Riel wrote:
> > The patch below implements RSS ulimit enforcement for 2.6.8-rc3-mm1.

> Wish there was something like RSS for cache, so that one process reading 
> every inode on the planet, or doing an md5 on an 11GB file wouldn't push 
> every damn process out if it's waiting for me to finish typing a line...

I guess that's beyond the scope of a simple patch, you may
be interested in CKRM for something like that:

	http://ckrm.sf.net/

For now I'm just interested in filling out the holes in
rlimit for the mainline kernel, as well as putting some
simple resource enforcement things in place.

I'm not about to add something complex at this stage ;) 

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

