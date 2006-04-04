Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWDDWHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWDDWHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWDDWHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:07:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16106 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750778AbWDDWHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:07:45 -0400
Date: Wed, 5 Apr 2006 08:07:31 +1000
From: Nathan Scott <nathans@sgi.com>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.16.1: XFS internal error xfs_btree_check_lblock at line 215 of file fs/xfs/xfs_btree.c
Message-ID: <20060405080731.B1071351@wobbly.melbourne.sgi.com>
References: <20060404212144.GM15722@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060404212144.GM15722@charite.de>; from Ralf.Hildebrandt@charite.de on Tue, Apr 04, 2006 at 11:21:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 11:21:44PM +0200, Ralf Hildebrandt wrote:
> I was running xfs_fsr on our /home at night when this happened:
> (Kernel 2.6.16.1)
> ...
> Apr  2 00:26:17 postamt kernel: Filesystem "sda5": XFS internal error xfs_btree_check_lblock at line 215 of file fs/xfs/xfs_btree.c.  Caller 0xb10dba58
> Apr  2 00:26:17 postamt kernel:  [xfs_btree_check_lblock+82/407] xfs_btree_check_lblock+0x52/0x197

What does xfs_repair report?  Is it (the forced shutdown) reproducible?

thanks.

-- 
Nathan
