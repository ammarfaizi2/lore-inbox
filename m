Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWBQQy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWBQQy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWBQQy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:54:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61411 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751140AbWBQQy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:54:56 -0500
Date: Fri, 17 Feb 2006 17:54:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
In-Reply-To: <20060217063157.B9349752@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0602171753590.27452@yvahk01.tjqt.qr>
References: <20060216183629.GA5672@skyscraper.unix9.prv>
 <20060217063157.B9349752@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> XFS mounting filesystem hda3
>> Starting XFS recovery on filesystem: hda3 (logdev: internal)
>> EIP:    0060:[xlog_recover_do_inode_trans+473/2688]    Tainted: P      VLI
>
>This indicates you are running recovery - run xfs_repair first
>if you know the filesystem is corrupt.
>
How does one know a filesystem got "corrupt enough" to require xfs_repair 
first?



Jan Engelhardt
-- 
