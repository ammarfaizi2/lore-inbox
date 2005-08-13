Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVHMUrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVHMUrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVHMUrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 16:47:12 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:38028 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932281AbVHMUrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 16:47:11 -0400
Message-ID: <42FE5C60.6000107@austin.rr.com>
Date: Sat, 13 Aug 2005 15:47:28 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, stephane.wirtel@belgacom.net
Subject: Re: Documenting the VFS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where can I found an up to date documentation about the VFS interface?
There is an ok chapter on filesystems in the O'Reilly Linux Kernel book,
and the Linux Device Drivers book (also from O'Reilly) is essential
reading.

Pay careful attention to fs/libfs.c and the nice small fs fs/ramfs which calls 
libfs which are both useful as they help understand the minimum that certain 
vfs interfaces require.  This was helpful to me when I wrote the cifs
filesystem.

Documentation/filesystems/vfs.txt has a little bit of documentation, as
does Documentation/Locking and Documentation/directory-locking.

I may try to write something (perhaps articles?) longer and
more formal if I get time.  

Finally the lwn series (weekly articles) on kernel development is
invaluable in describing what changes.


