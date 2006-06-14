Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWFNDRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWFNDRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 23:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWFNDRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 23:17:14 -0400
Received: from koto.vergenet.net ([210.128.90.7]:50103 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S964979AbWFNDRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 23:17:13 -0400
From: Horms <horms@verge.net.au>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipc namespace - compilation fix
In-Reply-To: <448DCE3F.8090905@sw.ru>
X-Newsgroups: gmane.linux.kernel
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.16-1-686 (i686))
Message-Id: <20060614031711.32B85340C1@koto.vergenet.net>
Date: Wed, 14 Jun 2006 12:17:11 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <448DCE3F.8090905@sw.ru> you wrote:
> Newsgroups: gmane.linux.kernel
> 
> [-- text/plain, encoding 7bit, charset: windows-1251, 6 lines --]
> 
> This patch fixes IPC namespace compilation when `make allnoconfig` is 
> used. Checked all 3 possible combinations of config options.

Hi, 

I can confirm that this patch resolves a compilation problem that
I was seeing in linux-2.6.17-rc6-mm2 on x86_64 with CONFIG_SYSVIPC
(and thus CONFIG_IPC_NS) unset.

CONFIG_SYSVIPC
CONFIG_IPC_NS

-- 
Horms                                           http://www.vergenet.net/~horms/

