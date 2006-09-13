Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWIMVk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWIMVk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIMVk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:40:58 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:24208 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750933AbWIMVk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:40:57 -0400
Subject: Re: [PATCH 2.6.18-rc6.mm2] revert migrate_move_mapping to use
	direct radix tree slot update
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609131344450.19101@schroedinger.engr.sgi.com>
References: <1158174574.5328.37.camel@localhost>
	 <Pine.LNX.4.64.0609131344450.19101@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: HP/OSLO
Date: Wed, 13 Sep 2006 17:40:22 -0400
Message-Id: <1158183622.5328.61.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 13:48 -0700, Christoph Lameter wrote:
> On Wed, 13 Sep 2006, Lee Schermerhorn wrote:
> 
>  > Now that the problem with the rcu radix tree replace slot function has
> > been fixed, we can, if Christoph agrees:
> 
> Instead of a new patch we could simply drop the patch
> 
> page-migration-replace-radix_tree_lookup_slot-with-radix_tree_lockup.patch
> 
> from Andrew's tree.

If you want to do it that way, I'll need to supply another patch to
clean up the compiler warnings [I think they were just warnings]
resulting from the change [at your suggestion ;-)] in the interface to
the radix tree functions.  

Lee

