Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUHDOSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUHDOSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUHDOSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:18:21 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:56848 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266014AbUHDOSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:18:20 -0400
To: Erik Mouw <erik@harddisk-recovery.com>, aia21@cantab.net
Cc: walt <wa1ter@myrealbox.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8-rc2-bk] New read/write bug in FAT fs
References: <4110CF29.8060401@myrealbox.com>
	<87657zkp21.fsf@devron.myhome.or.jp>
	<20040804134549.GD25969@harddisk-recovery.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 04 Aug 2004 23:17:28 +0900
In-Reply-To: <20040804134549.GD25969@harddisk-recovery.com>
Message-ID: <87oelrj8cn.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> writes:

> To minimise confusion, is it an idea that NTFS and FAT use the same
> mount options? Right now NTFS uses "nls" and VFAT "iocharset".

"nls" option is used by only NTFS. Other filesystems is using "iocharset".
Umm.. Why was "iocharset" option deprecated?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
