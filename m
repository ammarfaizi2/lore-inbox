Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbUKET01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbUKET01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbUKET01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:26:27 -0500
Received: from bender.bawue.de ([193.7.176.20]:34440 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261172AbUKET0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:26:17 -0500
Date: Fri, 5 Nov 2004 20:26:09 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-ac5: dm-snapshot and XFS failures
Message-ID: <20041105192609.GA5843@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041105073750.GA11812@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105073750.GA11812@sommrey.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 08:37:50AM +0100, Joerg Sommrey wrote:
> Hi,
> 
> in the last time I found some "strange" things happening while backing
> up.  For backing up I create a snapshot of all dm-devices, generate new
> UUIDs and mount the snapshot filesystems r/o (all XFS).
> While the backup was done there were hard lockups, XFS corruptions and
> a DM failure.

I was unable to remove the two stale snapshot volumes and tried to solve
that with a reboot.  "shutdown -r now" did hang. I was able to do a
SysRq-T trace, if this is of any interest. (rather large ~180K)

-jo

-- 
-rw-r--r--  1 jo users 63 2004-11-05 20:16 /home/jo/.signature
