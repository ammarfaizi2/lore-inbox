Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131491AbRCNSZi>; Wed, 14 Mar 2001 13:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131492AbRCNSZ2>; Wed, 14 Mar 2001 13:25:28 -0500
Received: from ns.caldera.de ([212.34.180.1]:35589 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131491AbRCNSZM>;
	Wed, 14 Mar 2001 13:25:12 -0500
Date: Wed, 14 Mar 2001 19:23:18 +0100
Message-Id: <200103141823.TAA11310@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: jjasen1@umbc.edu (John Jasen)
Cc: <linux-kernel@vger.kernel.org>, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu> you wrote:

> The problem:

> drivers change their detection schemes; and changes in the kernel can
> change the order in which devices are assigned names.
>
> For example, the DAC960(?) drivers changed their order of
> detecting controllers, and I did _not_ have fun, given that the machine in
> question had about 40 disks to deal with, spread across two controllers.

Put LABEL=<label set with e2label> in you fstab in place of the device name.

	Christoph

P.S. UUID= work, too - but I prefer a human-readable label...
-- 
Of course it doesn't work. We've performed a software upgrade.
