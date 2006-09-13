Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWIMUso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWIMUso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWIMUso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:48:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:56767 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751074AbWIMUsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:48:43 -0400
Date: Wed, 13 Sep 2006 13:48:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.18-rc6.mm2] revert migrate_move_mapping to use direct
 radix tree slot update
In-Reply-To: <1158174574.5328.37.camel@localhost>
Message-ID: <Pine.LNX.4.64.0609131344450.19101@schroedinger.engr.sgi.com>
References: <1158174574.5328.37.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Lee Schermerhorn wrote:

 > Now that the problem with the rcu radix tree replace slot function has
> been fixed, we can, if Christoph agrees:

Instead of a new patch we could simply drop the patch

page-migration-replace-radix_tree_lookup_slot-with-radix_tree_lockup.patch

from Andrew's tree.

Acked-by: Christoph Lameter <clameter@sgi.com>

