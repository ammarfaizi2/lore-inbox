Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUGBVaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUGBVaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUGBVaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:30:25 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:62990 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S264954AbUGBVaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:30:21 -0400
Date: Fri, 2 Jul 2004 23:30:16 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] [2.6.7 BK URL] NTFS 2.1.15 - Invaliade quotas
 when (re)mounting read-write.
In-Reply-To: <Pine.LNX.4.60.0407022149560.26457@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0407022313540.30622-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Jul 2004, Anton Altaparmakov wrote:

> Thanks!  This is a rather large update which puts a lot of infrastructure 
> code in place which was required to implement the actual new feature in 
> the driver which is that quotas are now invalidated when (re)mounting 
> read-write (obviously only if quota tracking is enabled).  This means 
> that resizing a file in ntfs will not make the quotas go out of sync 
> as Windows will rescan the volume on boot and update the quota charges 
> appropriately.

Hello, what happens if the occupied space would exceed the quota during
sync? Is the behavior consistent for all OS?

	Szaka

