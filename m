Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVCXPZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVCXPZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVCXPXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:23:36 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:5134 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262563AbVCXPUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:20:51 -0500
To: John Richard Moser <nigelenki@comcast.net>
Cc: ubuntu-devel <ubuntu-devel@lists.ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: vfat broken in 2.6.10?
References: <4241E3EA.4080501@comcast.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 25 Mar 2005 00:20:28 +0900
In-Reply-To: <4241E3EA.4080501@comcast.net> (John Richard Moser's message of
 "Wed, 23 Mar 2005 16:47:22 -0500")
Message-ID: <87fyyl3war.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser <nigelenki@comcast.net> writes:

> It appears dosfsck may not be working quite right.  I've taken this into
> account, hence the second pass after each fsck.  This is either a
> dosfsck issue, a usb-storage issue for the PNY compact flash drive, or
> an issue with vfat itself.
>
> So either LKML needs to fix the drivers, or Ubuntu needs to upgrade/fix
> dosfsck or some patch they've applied to the kernel.

Can you try http://user.parknet.co.jp/hirofumi/tmp/fatfsprogs.tar.bz2,
or most recently released dosfstools (2.11 or later)?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
