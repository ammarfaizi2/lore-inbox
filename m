Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTIOVKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTIOVKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:10:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:59072 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261644AbTIOVKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:10:35 -0400
Date: Mon, 15 Sep 2003 14:10:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: Monster file_lock_cache entry in /proc/slabinfo
Message-ID: <20030915141027.G1363@osdlab.pdx.osdl.net>
References: <m3k78923wy.fsf@lugabout.jhcloos.org> <20030915132514.0bee90bc.akpm@osdl.org> <20030915134202.A1378@osdlab.pdx.osdl.net> <20030915132514.0bee90bc.akpm@osdl.org> <m38yop22jt.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m38yop22jt.fsf@lugabout.jhcloos.org>; from cloos@jhcloos.com on Mon, Sep 15, 2003 at 04:56:54PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James H. Cloos Jr. (cloos@jhcloos.com) wrote:
> Is file_lock_cache only a recent issue, then?  The slowdown has been
> going on for at least the last 20 or so release tags.

Comparing the patch lines to the repo history in bk, this looks like
it's been around since 2.5.39 or so...I suspect this patch is all you
need.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
