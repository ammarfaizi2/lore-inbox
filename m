Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTIOUmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTIOUmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:42:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:28846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261598AbTIOUmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:42:10 -0400
Date: Mon, 15 Sep 2003 13:42:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Monster file_lock_cache entry in /proc/slabinfo
Message-ID: <20030915134202.A1378@osdlab.pdx.osdl.net>
References: <m3k78923wy.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3k78923wy.fsf@lugabout.jhcloos.org>; from cloos@jhcloos.com on Mon, Sep 15, 2003 at 04:27:25PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James H. Cloos Jr. (cloos@jhcloos.com) wrote:
> 
> The file_lock_cache entry seemed rather engrossed:

Is this a recent 2.6.0-test?  Matthew Wilcox posted a patch for this:

http://ftp.linux.org.uk/pub/linux/willy/patches/flock-memleak.diff

You might give that a try.
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
