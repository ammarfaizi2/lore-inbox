Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVE3CsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVE3CsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 22:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVE3CsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 22:48:00 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:49846 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261499AbVE3Cr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 22:47:59 -0400
Date: Mon, 30 May 2005 04:47:58 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID-5 design bug (or misfeature)
In-Reply-To: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net>
Message-ID: <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz>
References: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz> you wrote:
> > I think Linux should stop accessing all disks in RAID-5 array if two disks
> > fail and not write "this array is dead" in superblocks on remaining disks,
> > efficiently destroying the whole array.
>
> I agree with you, however it is a pretty damned stupid idea to use raid-5
> for a root disk (I was about to say it is not a good idea to use raid-5 on
> linux at all :)

But root disk might fail too... This way, the system can't be taken down
by any single disk crash.

Mikulas
