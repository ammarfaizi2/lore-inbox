Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUHDM5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUHDM5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUHDM5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:57:48 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:64910 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265154AbUHDM5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:57:46 -0400
Message-ID: <4110CF29.8060401@myrealbox.com>
Date: Wed, 04 Aug 2004 04:57:29 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, hirofumi@mail.parknet.co.jp
Subject: [2.6.8-rc2-bk] New read/write bug in FAT fs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the changesets posted by Linus on August 2 introduced
a bug in the FAT fs:

Even when a fat32 fs is mounted read-write I now get error
messages claiming the fs is 'read-only' when I try to write
to it.

The only change I can see which fits the timing is to inode.c
which was posted on August 2.  Apologies if I am blaming
the wrong changeset.

Could someone confirm this bug for me?

Thanks!
