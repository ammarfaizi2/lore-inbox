Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVAGVoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVAGVoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVAGVnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:43:39 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:19213 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261634AbVAGVmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:42:15 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/fat/cache.c: make __fat_access static
References: <20050106225351.GG28628@stusta.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 08 Jan 2005 06:41:06 +0900
In-Reply-To: <20050106225351.GG28628@stusta.de> (Adrian Bunk's message of
 "Thu, 6 Jan 2005 23:53:51 +0100")
Message-ID: <87oeg0c3yl.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> The patch below makes a needlessly global function static.
>
>
> diffstat output:
>  fs/fat/cache.c           |    2 +-
>  include/linux/msdos_fs.h |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks. applied.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
