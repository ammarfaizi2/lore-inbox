Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTKXRth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 12:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTKXRth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 12:49:37 -0500
Received: from ns.suse.de ([195.135.220.2]:25783 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263824AbTKXRtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 12:49:35 -0500
Date: Mon, 24 Nov 2003 18:49:34 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: ramdisk contents lost with 2.6
Message-ID: <20031124174934.GA32112@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

is it only me or is the file really gone with 2.6?

umount -v /mnt
/sbin/mkfs.ext2 /dev/ram3
mount -v /dev/ram3 /mnt
cp /etc/hosts /mnt
sync
umount -v /mnt
mount -v /dev/ram3 /mnt
ls -l /mnt/hosts
umount -v /mnt


works ok with 2.4.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
