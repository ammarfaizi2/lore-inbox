Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269087AbUJEQAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269087AbUJEQAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269158AbUJEPw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:52:27 -0400
Received: from math.ut.ee ([193.40.5.125]:35305 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S269793AbUJEPvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:51:03 -0400
Date: Tue, 5 Oct 2004 18:50:48 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: lazy umount not working (udev & tmpfs on /dev)
In-Reply-To: <20041005142855.GK23987@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.44.0410051848580.20376-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Could you add printk to sys_mount() and sys_umount(), so that
> we could at least see which one is a problem?  Just "called mount"/"called
> umount", nothing fancy with arguments...

Tried it.
Ignoring matching 2 mounts and 2 umounts for /dev/pts and /dev/shm,
there are exactly 2 mounts on udev start and 2 umounts on udev stop.

-- 
Meelis Roos (mroos@linux.ee)

