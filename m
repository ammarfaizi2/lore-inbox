Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUFRU33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUFRU33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUFRU32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:29:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:3243 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263295AbUFRU1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:27:43 -0400
Date: Fri, 18 Jun 2004 13:27:42 -0700
From: Chris Wright <chrisw@osdl.org>
To: Adrian Almenar <aalmenar@conectium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs directories...
Message-ID: <20040618132742.F22989@build.pdx.osdl.net>
References: <20040618155117.0bffd01d@er-murazor.conectium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040618155117.0bffd01d@er-murazor.conectium.com>; from aalmenar@conectium.com on Fri, Jun 18, 2004 at 03:51:17PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Almenar (aalmenar@conectium.com) wrote:
> i was looking at /sys on my machine yesterday and i found something
> strange.
> 
> cd
> /sys/block/hda/device/block/device/block/device/block/device/block/...
> and that continues being almost infinite and recursive, it is normal

Both /sys/block/hda/device and the next element 'block' are symlinks,
so it'll top out after 40 (enforced by vfs).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
