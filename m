Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUG2AJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUG2AJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUG2AJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:09:20 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:57833 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267369AbUG2AI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:08:26 -0400
Date: Thu, 29 Jul 2004 11:04:03 +1000
From: Nathan Scott <nathans@sgi.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.6.8-rc2][XFS] Page allocation failure
Message-ID: <20040729010403.GC800@frodo>
References: <20040725173022.GA8345@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040725173022.GA8345@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Sun, Jul 25, 2004 at 07:30:23PM +0200, Kronos wrote:
> ...
> It seems that XFS failed an order 5 allocation (not atomic) on the read

Hmm, that file is fragmented up the wazoo for some reason
(see the xfs_bmap -vv output on the file).  Any chance you
know how it was written originally?  In particular, was it
written with O_SYNC set?  (or via a sync NFS mount?).
Thanks.

> path two times (there are 80 secs between the warnings). Can I assume
> that the FS is not harmed?

Yes you can (those were warning messages & not oopsen).

cheers.

-- 
Nathan
