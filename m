Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWFZFZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWFZFZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 01:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWFZFZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 01:25:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17879 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932433AbWFZFZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 01:25:11 -0400
Date: Mon, 26 Jun 2006 15:24:57 +1000
From: Nathan Scott <nathans@sgi.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: xfs@oss.sgi.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: XFS warning (2.6.17-git9)
Message-ID: <20060626152457.A1264508@wobbly.melbourne.sgi.com>
References: <20060625221459.7e72bbad.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060625221459.7e72bbad.rdunlap@xenotime.net>; from rdunlap@xenotime.net on Sun, Jun 25, 2006 at 10:14:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 10:14:59PM -0700, Randy.Dunlap wrote:
> 
> was a new (second) parameter added?
> 
> on xfs_file_close:
> fs/xfs/linux-2.6/xfs_file.c:555: warning: initialization from incompatible pointer type
> fs/xfs/linux-2.6/xfs_file.c:580: warning: initialization from incompatible pointer type
> 

Its been fixed already in Linus git tree.  A second parameter was
added just after the XFS callout was added.

-- 
Nathan
