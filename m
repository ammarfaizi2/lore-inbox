Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUAYSdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUAYSdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:33:24 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:52403 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265155AbUAYSdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:33:23 -0500
Date: Sun, 25 Jan 2004 11:33:21 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Lutz Vieweg <lkv@isg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle disks? (to allow spin-downs)
Message-ID: <20040125183321.GE1092@schnapps.adilger.int>
Mail-Followup-To: Lutz Vieweg <lkv@isg.de>,
	linux-kernel@vger.kernel.org
References: <40140B0A.90707@isg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40140B0A.90707@isg.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 25, 2004  19:29 +0100, Lutz Vieweg wrote:
> Alas, since an upgrade to kernel 2.6 and ext3 filesystem, I cannot find a 
> way to let the harddisk spin down - I found out that "kjournald" writes a
> few blocks every few seconds.

Loop for laptop-mode patches, which should allow you to do this.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

