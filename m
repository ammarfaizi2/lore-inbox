Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbUJZE0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbUJZE0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUJZBj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:39:26 -0400
Received: from zeus.kernel.org ([204.152.189.113]:471 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262084AbUJZBXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:23:42 -0400
Date: Mon, 25 Oct 2004 16:09:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: hans lambrechts <hans.lambrechts@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.10-rc1 doesn't boot
Message-Id: <20041025160924.0adb3d32.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410231616120.6852@pc.home.lan>
References: <Pine.LNX.4.58.0410231616120.6852@pc.home.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hans lambrechts <hans.lambrechts@skynet.be> wrote:
>
> when i'm booting my box with kernel 2.6.10-rc1 i get this message:
> 
> 	VFS: cannot open root device "sdb7" or unknown-block (8,32)
> 
> i've tried "root=8:32" w/o any improvement
> kernel 2.6.9 is booting w/o complaining with "root=/dev/sdb7"

Probably something has gone wrong with the device known as sdb.  Or its
driver.  We'd need to see more of the boot messages to tell.  Did the scsi
layer say anything nasty when it was probing devices?

