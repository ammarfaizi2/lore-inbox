Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbUDBB7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbUDBB7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:59:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:44442 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263538AbUDBB7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:59:18 -0500
Date: Thu, 1 Apr 2004 17:59:14 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401175914.A22989@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040401173034.16e79fee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040401173034.16e79fee.akpm@osdl.org>; from akpm@osdl.org on Thu, Apr 01, 2004 at 05:30:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Rumour has it that the more exhasperated among us are brewing up a patch to
> login.c which will allow capabilities to be retained after the setuid.  So
> you do
> 
> 	echo "oracle CAP_IPC_LOCK" > /etc/logincap.conf
> 
> And that's it.
> 
> See any reason why this won't work?

Looks ok, and sounds very similar to what pam_cap does.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
