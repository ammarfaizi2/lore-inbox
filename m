Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWFUU2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWFUU2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWFUU2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:28:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751454AbWFUU2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:28:38 -0400
Date: Wed, 21 Jun 2006 13:25:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: tytso@mit.edu, randy.dunlap@oracle.com, arjan@infradead.org,
       linux-kernel@vger.kernel.org, bcollins@ubuntu.com
Subject: Re: reviewing Ubuntu kernel patches
Message-Id: <20060621132512.12db84f6.akpm@osdl.org>
In-Reply-To: <20060621173841.GH9111@stusta.de>
References: <44909A1D.3030404@oracle.com>
	<1150386150.2987.9.camel@laptopd505.fenrus.org>
	<44924425.1040501@oracle.com>
	<20060616140334.GA24491@thunk.org>
	<20060621173841.GH9111@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 19:38:41 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> When Andrew merges some small fix into an existing patch in -mm
> (e.g. "make a function static" or "fix a compile error"), he adds the 
> Signed-off-by line of the small fix to the Signed-off-by lines of the 
> patch.
> 
> But the submitter of the fix does not necessarly have checked the 
> legal or technical status of the rest of the patch.
> 
> As an example, my only contribution to commit 
> 6b3934ef52712ece50605dfc72e55d00c580831a was making signal_cachep 
> static, and I do refuse any legal or technical responsibility for 
> the rest of the patch (this shouldn't imply the rest of the patch was 
> bad - it's simply not me who can is responsible for it).

Yes, nowadays I give the folded-in patch a mini-changelog, as in

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/broken-out/slab-kmalloc-kzalloc-comments-cleanup-and-fix.patch
