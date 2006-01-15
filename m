Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWAOVWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWAOVWT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWAOVWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:22:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:65233 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750893AbWAOVWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:22:18 -0500
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.15: access permission filesystem 0.17
References: <87ek3a8qpy.fsf@goat.bogus.local>
	<200601142345.47473.ioe-lkml@rameria.de>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sun, 15 Jan 2006 22:22:12 +0100
Message-ID: <878xth6vaz.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> writes:

> On Saturday 14 January 2006 22:06, Olaf Dietsche wrote:
> [PATCH]
>
> accessfs_readdir_aux() in fs/accessfs/inode.c 
>
> should set DT_REG, since accessfs supports just directories
> and regular files. The directory is already handled before
> in the sole caller of accessfs_readdir_aux().
>
> This saves the superflous stat(2) call after readdir(2).

Thanks for this hint, it is much appreciated.

Regards, Olaf.
