Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbUKVQa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbUKVQa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbUKVQ3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:29:42 -0500
Received: from holomorphy.com ([207.189.100.168]:10906 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262152AbUKVPvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:51:13 -0500
Date: Mon, 22 Nov 2004 07:51:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
Message-ID: <20041122155106.GG2714@holomorphy.com>
References: <200411221530.30325.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411221530.30325.lkml@kcore.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 03:30:29PM +0100, Jan De Luyck wrote:
> [resend with correct email address for LKML]
> [Please CC all answers from linux-xfs to me, since I'm not subscribed on that list]
> Yesterday I encountered an on-the-fly corruption of my /home filesystem. It worked perfectly one second, the next I hit these nice errors:
> Nov 21 16:37:22 precious kernel: 0x0: 31 9e ce 63 cf ff 9c cf ff 31 61 63 ff ff ff ff 
> Nov 21 16:37:23 precious kernel: Filesystem "hda5": XFS internal error xfs_da_do_buf(2) at line 2273 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01fb908
> Nov 21 16:37:23 precious kernel:  [xfs_da_do_buf+905/2160] xfs_da_do_buf+0x389/0x870

I don't have any ideas at the moment, but please cc: me also. I'd like
to watch for issues I do understand as this bug's nature is clarified.


-- wli
