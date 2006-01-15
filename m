Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWAOU5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWAOU5y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWAOU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:57:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42932 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750808AbWAOU5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:57:53 -0500
Date: Sun, 15 Jan 2006 21:57:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: linux-kernel@vger.kernel.org,
       Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Subject: Re: [PATCH] 2.6.15: Filesystem capabilities 0.16
In-Reply-To: <200601142358.31628.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.61.0601152156580.4240@yvahk01.tjqt.qr>
References: <8764om8pzl.fsf@goat.bogus.local> <200601142358.31628.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> This patch implements filesystem capabilities. It allows to run
>> privileged executables without the need for suid root.
>
>Why not implement this via xattr framework and the "system." 
>namespace there? I would suggest "system.posix_capabilties" for this.
>
>That way you can reduce your infrastructure, take advantage
>of caching features, have user space tools for viewing and changing 
>this and resize2fs works for it now or soon.
>
>What do you think?

I think some filesystems lack the luxury of xattrs.



Jan Engelhardt
-- 
