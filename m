Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVBGOeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVBGOeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVBGOb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:31:29 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:30440 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261432AbVBGOaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:30:11 -0500
To: linux lover <linux_lover2004@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to read file in kernel module?
References: <20050207061718.47940.qmail@web52203.mail.yahoo.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Mon, 07 Feb 2005 15:29:52 +0100
Message-ID: <87ekfsl9y7.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux lover <linux_lover2004@yahoo.com> writes:

> Now what i want is to use same bufproc_read &
> bufproc_write  functions defined in /proc file
> handling kernel module to be used in another kernel
> module to read that /proc/file in kernel module.The
> second kernel module only used to read /proc file in
> kernel. I am not understanding how can i open that
> /proc/file in second kenrel module to read in kernel?

Look at kernel_read() in fs/exec.c and fs/binfmt_*.c

Regards, Olaf.
