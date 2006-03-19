Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWCSJ1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWCSJ1i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 04:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWCSJ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 04:27:38 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:19617 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751181AbWCSJ1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 04:27:38 -0500
Date: Sun, 19 Mar 2006 10:27:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
In-Reply-To: <17436.60328.242450.249552@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr>
References: <17436.60328.242450.249552@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hence the question in the subject:
>
>  Who uses the 'nodev' flag in /proc/filesystems?
>
>Are there any known users of this flag?
>

pam_mount. If a specific filesystem is nodev, --bind or --move, fsck is 
skipped. If you want to change /proc/filesystems, you can do so as long as 
you provide an alternative ;) Does not need to be stable, as 
/proc/filesystems is only used when a volume is initially mounted in 
pam_mount.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
