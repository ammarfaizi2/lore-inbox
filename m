Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUEWNpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUEWNpv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 09:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUEWNpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 09:45:51 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:49421 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262802AbUEWNpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 09:45:50 -0400
To: =?utf-8?b?xLBzbWFpbCBEw7ZubWV6?= <kde@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Vfat not working in 2.6.6 or 2.6.6-mm5
References: <200405230121.05051.kde@myrealbox.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 23 May 2004 22:45:35 +0900
In-Reply-To: <200405230121.05051.kde@myrealbox.com>
Message-ID: <87d64vcl4w.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> May 23 01:13:23 localhost kernel: FAT: Filesystem panic (dev sda1)
> May 23 01:13:23 localhost kernel:     fat_get_cluster: invalid cluster chain 
> (i_pos 652)
> 
> Looks like fat support is broken or am I missing something?

Looks like it read the corrupted filesystem. Can you try "dosfsck" or
friends after backup the flash disk?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
