Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUKUHvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUKUHvL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 02:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbUKUHvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 02:51:02 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:57231 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261907AbUKUHu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 02:50:59 -0500
To: pavel@ucw.cz
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Sun, 21 Nov 2004 08:42:55 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu> <20041118144634.GA7922@openzaurus.ucw.cz> <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1CVmUn-0007rZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 08:50:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And vica versa for write.  FUSE will have some overhead of context
> switches, but in the optimal case (sequential read), the readahead
> code will bundle read requests, and with a 128MByte read, the cost of
                                             ^^^^^^^^
I meant 128kbyte of course.  We don't have that much memory yet :)

Miklos
