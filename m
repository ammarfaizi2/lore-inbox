Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUEWQHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUEWQHU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUEWQHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:07:19 -0400
Received: from [62.29.76.210] ([62.29.76.210]:13440 "EHLO localhost")
	by vger.kernel.org with ESMTP id S263126AbUEWQHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:07:18 -0400
From: =?utf-8?q?=C4=B0smail_D=C3=B6nmez?= <kde@myrealbox.com>
Organization: Bogazici University
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Vfat not working in 2.6.6 or 2.6.6-mm5
Date: Sun, 23 May 2004 19:08:08 +0300
User-Agent: KMail/1.6.52
Cc: linux-kernel@vger.kernel.org
References: <200405230121.05051.kde@myrealbox.com> <87d64vcl4w.fsf@devron.myhome.or.jp>
In-Reply-To: <87d64vcl4w.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="Iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405231908.09221.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 May 2004 16:45, OGAWA Hirofumi wrote:
> > May 23 01:13:23 localhost kernel: FAT: Filesystem panic (dev sda1)
> > May 23 01:13:23 localhost kernel:     fat_get_cluster: invalid cluster
> > chain (i_pos 652)
> >
> > Looks like fat support is broken or am I missing something?
>
> Looks like it read the corrupted filesystem. Can you try "dosfsck" or
> friends after backup the flash disk?
>
Thanks you! Looks like file system was corrupt.

Regards,
/ismail

