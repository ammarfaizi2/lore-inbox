Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUDBCdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbUDBCdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:33:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:51377 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263004AbUDBCdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:33:16 -0500
Date: Thu, 1 Apr 2004 18:33:12 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401183312.Z21045@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040401173034.16e79fee.akpm@osdl.org> <20040401175914.A22989@build.pdx.osdl.net> <20040402020915.GO18585@dualathlon.random> <20040401183026.6844597a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040401183026.6844597a.akpm@osdl.org>; from akpm@osdl.org on Thu, Apr 01, 2004 at 06:30:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> > just curious, how does this work through 'su'? Does su check
> > logincap.conf too?
> 
> I guess so.

Or let pam_cap do it so you don't have to modify all the apps just the pam
confs.

> Well you have a local short-term solution...
> 
> One thing I was wondering was whether /proc/sys/vm/disable_cap_mlock should
> hold a GID rather than a boolean.  So you do
> 
> 	echo groupof oracle > /proc/sys/vm/disable_cap_mlock

Heh, was just thinking the same.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
