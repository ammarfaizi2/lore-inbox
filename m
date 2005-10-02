Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVJBVbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVJBVbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 17:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVJBVbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 17:31:12 -0400
Received: from dvhart.com ([64.146.134.43]:55697 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932078AbVJBVbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 17:31:11 -0400
Date: Sun, 02 Oct 2005 14:31:09 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rohit.seth@intel.com
Subject: Re: 2.6.14-rc2-mm1 (Oops, possibly Netfilter related?)
Message-ID: <48080000.1128288669@[10.10.2.4]>
In-Reply-To: <20051002101319.659afcde.pj@sgi.com>
References: <20050921222839.76c53ba1.akpm@osdl.org><4338F136.1020404@reub.net><20050927004410.29ab9c03.akpm@osdl.org><925820000.1127847556@flay> <20051002101319.659afcde.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Paul Jackson <pj@sgi.com> wrote (on Sunday, October 02, 2005 10:13:19 -0700):

> Martin, responding to Andrew:
>> > I've dropped that patch.  Joel Schopp is working on Mel Gorman's patches
>> > which address fragmentation at this level.  If that code gets there then we
>> > can take another look at
>> > mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch.
>> 
>> Me no understand. We're going to deliberately cause fragmentation in order
>> to defragment it again later ???
> 
> I thought that the patches of Mel Gorman and Joel Schopp were reducing
> fragmentation, not causing it.

They were. but mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk
seems to be going in the opposite direction.

M.

