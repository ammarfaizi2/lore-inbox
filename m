Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUBLInQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 03:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUBLInP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 03:43:15 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:29901 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S266302AbUBLInH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 03:43:07 -0500
Date: Thu, 12 Feb 2004 09:43:03 +0100 (MET)
Message-Id: <200402120843.i1C8h3S18602@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: notyet in mount_is_safe()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

So what's the reason for not yet allowing bind mounts for non-root
users?  That #ifdef has been there since ages.

I'm also interested whether it would be possible to allow non-root
mounts of "safe" filesystems.  Or is there some inherent security
problem with that?  By "safe" I mean a filesystem that would not allow
access to more things that the user is normally allowed.  (e.g.
filesystems for ftp/ssh/tar etc.)

Thanks,
Miklos

