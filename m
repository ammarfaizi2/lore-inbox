Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWFIToA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWFIToA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWFIToA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:44:00 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:62929 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030461AbWFITn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:43:59 -0400
To: Jeff Garzik <jeff@garzik.org>
cc: Michael Poole <mdpoole@troilus.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3 
In-reply-to: Your message of Fri, 09 Jun 2006 14:55:56 EDT.
             <4489C43C.6000906@garzik.org> 
Date: Fri, 09 Jun 2006 12:42:52 -0700
Message-Id: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2006 14:55:56 EDT, Jeff Garzik wrote:
> 
> Because it's called backwards compat, when it isn't?
> Because it is very difficult to find out which set of kernels you are 
> locked out of?
> Because the filesystem upgrade is stealthy, occurring as it does on the 
> first data write?

Actually, the *only* point being contended here is running older
kernels on some newer filesystems (created originally with a newer
kernel), right?

Or do you have examples of where current kernels could not deal
with an ext3 feature at some point in time?

I would argue that 0.001% of all Linux *users* actually worry about
this - most of them are right here on the development mailing list.
So, that group is more vocal, for sure.  But, if it works for 99.99+%
users, aren't we still on the good path, from the point of view of
those people who actually *use* Linux the most?

gerrit
