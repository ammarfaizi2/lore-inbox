Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVE2X6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVE2X6M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 19:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVE2X6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 19:58:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:41960 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261470AbVE2X6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 19:58:09 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RAID-5 design bug (or misfeature)
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net>
Date: Mon, 30 May 2005 01:58:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz> you wrote:
> I think Linux should stop accessing all disks in RAID-5 array if two disks
> fail and not write "this array is dead" in superblocks on remaining disks,
> efficiently destroying the whole array.

I agree with you, however it is a pretty damned stupid idea to use raid-5
for a root disk (I was about to say it is not a good idea to use raid-5 on
linux at all :)

Gruss
Bernd
