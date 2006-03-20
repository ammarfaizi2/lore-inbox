Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbWCTQG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWCTQG1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWCTQGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:06:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61088 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965759AbWCTQGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:06:20 -0500
Date: Mon, 20 Mar 2006 17:06:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
In-Reply-To: <17438.13214.307942.212773@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.61.0603201659250.22395@yvahk01.tjqt.qr>
References: <17436.60328.242450.249552@cse.unsw.edu.au>
 <Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr> <17438.13214.307942.212773@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Pam_mount .. (google...) you learn something new every day, don't you!
>
>That sounds like a reasonable usage of 'nodev', though testing for
>/sbin/fsck.$FSTYPE might do as well...
>

Quite good idea, and it would make pam_mount more portable. I'll add that 
to my todo list. :)

I wonder if there is a filesystem that is nodev, but has fsck.


Jan Engelhardt
-- 
