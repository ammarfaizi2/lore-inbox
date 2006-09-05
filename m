Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWIEUTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWIEUTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWIEUTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:19:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57861 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030246AbWIEUTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:19:01 -0400
Date: Tue, 5 Sep 2006 20:18:46 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Whitehouse <swhiteho@redhat.com>,
       linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 03/16] GFS2: bmap and inode functions
Message-ID: <20060905201846.GG7043@ucw.cz>
References: <1157031054.3384.788.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0609011355410.15283@yvahk01.tjqt.qr> <20060902060939.GB16484@elte.hu> <Pine.LNX.4.61.0609020914570.24701@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609020914570.24701@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> 	if(ip == NULL)
> >> 		return;
> >> 	if(test_bit(GLF_DIRTY, &gl->gl_flags))
> >> 		gfs_inode_attr_in(ip);
> >> 	gfs2_meta_cache_flush(ip);
> >
> >btw., it should be "if (", not "if(".
> 
> There is no such rule in CodingStyle.

But there should be... so that if does not look like function call.

							Pavel

-- 
Thanks for all the (sleeping) penguins.
