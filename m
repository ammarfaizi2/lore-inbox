Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVBGW0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVBGW0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVBGW0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:26:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:29113 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261281AbVBGW0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:26:07 -0500
Date: Mon, 7 Feb 2005 14:26:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8)
Message-ID: <20050207142603.A469@build.pdx.osdl.net>
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050207193129.GB834@halcrow.us>; from mhalcrow@us.ibm.com on Mon, Feb 07, 2005 at 01:31:30PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Halcrow (mhalcrow@us.ibm.com) wrote:
> This is the third in a series of eight patches to the BSD Secure
> Levels LSM.  It moves the claim on the block device from the inode
> struct to the file struct in order to address a potential
> circumvention of the control via hard links to block devices.  Thanks
> to Serge Hallyn for pointing this out.

Hard links still point to same inode, what's the issue that this
addresses?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
