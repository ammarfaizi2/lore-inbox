Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbTBFRpg>; Thu, 6 Feb 2003 12:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267376AbTBFRpg>; Thu, 6 Feb 2003 12:45:36 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:48871 "EHLO
	minerva") by vger.kernel.org with ESMTP id <S267375AbTBFRpf>;
	Thu, 6 Feb 2003 12:45:35 -0500
Date: Thu, 6 Feb 2003 11:55:08 -0600
From: Matt Reppert <arashi@yomerashi.yi.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-Id: <20030206115508.4425d994.arashi@yomerashi.yi.org>
In-Reply-To: <20030206173050.GA15854@work.bitmover.com>
References: <20030205174021.GE19678@dualathlon.random>
	<20030205102308.68899bc3.akpm@digeo.com>
	<20030205184535.GG19678@dualathlon.random>
	<20030205114353.6591f4c8.akpm@digeo.com>
	<20030205141104.6ae9e439.arashi@yomerashi.yi.org>
	<20030205233115.GB14131@work.bitmover.com>
	<20030205233705.A31812@infradead.org>
	<20030205235706.GB21064@work.bitmover.com>
	<20030206095850.D18636@schatzie.adilger.int>
	<20030206173050.GA15854@work.bitmover.com>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003 09:30:50 -0800
Larry McVoy <lm@bitmover.com> wrote:
> What I'd really like to know is if we really need a glibc2.3 image. 
> Would the guy who had the segfaults step foward and confirm/deny the
> use of the static image?  We haven't had any other problem reports
> related to glibc2.3 so it may be there is no need to do anything but
> kill the static version. 

Indeed; I've had time to try the glibc2.2 version, and this seems to
work fine running a quick bk changes. The static version is what was
segfaulting. Sorry for the noise.

Thanks,
Matt
