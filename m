Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWDJP25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWDJP25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 11:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWDJP25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 11:28:57 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:60391 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750913AbWDJP24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 11:28:56 -0400
Date: Mon, 10 Apr 2006 17:28:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Sumit Narayan <talk2sumit@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Subject: Re: deleting partition does not effect superblock?
In-Reply-To: <20060406065832.GK13324@lug-owl.de>
Message-ID: <Pine.LNX.4.61.0604101725130.922@yvahk01.tjqt.qr>
References: <1458d9610604052337p2cafa6c8j78fc6da8c5f8be1a@mail.gmail.com>
 <20060406065832.GK13324@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>deleted) or otherwise modified. So it's perfectly okay to delete such
>a container (eg. remove start and end from the partition table) and
>recreate it at some time later (by adding those values back to the
>partition table.)  As long as the new container starts at the same
>location, a filesystem driver will be able to find the old
>information. If you start a block later, it won't find it's
>superblocks.
>
If using a filesystem with replicated superblocks (ext*, xfs), then ...?
[Includes expecting weird breakage.]



Jan Engelhardt
-- 
