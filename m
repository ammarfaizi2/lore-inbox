Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265495AbUGGVeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbUGGVeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUGGVeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:34:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:50157 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265495AbUGGVeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:34:17 -0400
Subject: Re: Unnecessary barrier in sync_page()?
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040707143015.03379d0f.akpm@osdl.org>
References: <20040707175724.GB3106@logos.cnet>
	 <20040707182025.GJ28479@dualathlon.random>
	 <20040707112953.0157383e.akpm@osdl.org>
	 <20040707184202.GN28479@dualathlon.random>
	 <1089233823.3956.80.camel@watt.suse.com>
	 <20040707210608.GS28479@dualathlon.random>
	 <20040707143015.03379d0f.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089236056.3956.91.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Jul 2004 17:34:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-07 at 17:30, Andrew Morton wrote:

> But I cannot think of any callers of sync_page() who don't have a ref on
> the inode, so...

I looked pretty hard for callers that didn't have a ref on the inode
while debugging the backing dev oopsen...I couldn't find any.

-chris


