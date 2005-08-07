Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753124AbVHGXoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbVHGXoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 19:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753125AbVHGXoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 19:44:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24533 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753124AbVHGXoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 19:44:13 -0400
Date: Sun, 7 Aug 2005 16:44:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-ID: <20050807234411.GE7991@shell0.pdx.osdl.net>
References: <372830000.1123456808@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <372830000.1123456808@[10.10.2.4]>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin J. Bligh (mbligh@mbligh.org) wrote:
> Starting on the work to merge xen cleanly as a subarch.
> Introduce make_pages_readonly and make_pages_writable where appropriate 
> for Xen, defined as a no-op on other subarches. Same for 

Maybe this is a bad name, since make_pages_readonly/writable has
intutitive meaning, and then is non-inutitively a no-op (for default).

thanks,
-chris
