Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVAVIyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVAVIyi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 03:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVAVIyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 03:54:38 -0500
Received: from mailout.despammed.com ([65.112.71.29]:61666 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S262683AbVAVIyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 03:54:37 -0500
Date: Sat, 22 Jan 2005 02:37:42 -0600 (CST)
Message-Id: <200501220837.j0M8bgk22582@mailout.despammed.com>
From: ndiamond@despammed.com
To: linux-kernel@vger.kernel.org
Subject: Re: negative diskspace usage
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:

> After cleaning up a bit df suddenly showed interesting results:
> 
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/md4             1019M  -64Z  1.1G 101% /tmp
> 
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/md4               1043168 -73786976294838127736   1068904 101% /tmp

It looks like Windows 95's FDISK
command created the partitions.
After that it doesn't matter which
operating systems you connect the
drive to when formatting the
partitions and writing files and
cleaning whatever you want to clean.
The partition boundaries still remain
where Windows 95 put them, and you
have overlapping partitions.

After backing up whatever files you
can still access (and don't trust
the contents of the files either),
zero out the MBR and start over.
