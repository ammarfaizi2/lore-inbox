Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTEFMRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTEFMQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:16:51 -0400
Received: from ns.suse.de ([213.95.15.193]:58128 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262700AbTEFMQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:16:13 -0400
From: Marcus Meissner <meissner@suse.de>
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
To: =?ISO-8859-15?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Date: Tue, 06 May 2003 14:28:44 +0200
References: <20030505210811.GC7049@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <1052218090.28792.15.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel> <20030506120939.GB15261@wohnheim.fh-wedel.de.suse.lists.linux.kernel>
Organization: SuSE Linux AG
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20030506122844.95332D872@Hermes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > My reasons for this patch:
> 
> - Even if x86 is not the only platform that uses MSDOS partitions,
> this should be a positive list, not a negative list. Else every new
> platform has to explicitly express, *not* to use MSDOS partitions.
> Seems awkward.
> 
> - Any platform needing MSDOS partitions but not explicitly listed can
> still turn that option on through the advanced partitioning.
> Currently, allnoconfig gives you MSDOS partitioning, which is not very
> intuitive.

Every platform that supports USB will be able to read USB Storage
Devices which almost everytime have FAT filesystems with MSDOS partitions.

So short of S/390 you get like every platform.

Ciao, Marcus
