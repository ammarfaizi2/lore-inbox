Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUB0A6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUB0A4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:56:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:34215 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261341AbUB0AyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:54:16 -0500
Date: Thu, 26 Feb 2004 16:56:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.C. Wren" <jcwren@jcwren.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sleeping function called from invalid context in 2.6.3
Message-Id: <20040226165609.1c9e6657.akpm@osdl.org>
In-Reply-To: <403E4F63.9090301@jcwren.com>
References: <403E4F63.9090301@jcwren.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.C. Wren" <jcwren@jcwren.com> wrote:
>
>    I keep getting the following error whenever I attempt to use k3b (CD 
> burning software).  Kernel 2.6.3, /dev/hdc is a Hewlett-Packard DVD 
> Writer 200, ATAPI CD/DVD-ROM drive.  I've posted my .config, lilo.conf, 
> dmesg log, gcc version, and a copy of the error message at 
> http://tinymicros.com/kernel, rather than attaching all of it.  hdc=scsi 
> is on the append line for lilo.

Please try the ide-scsi error handling rework in 2.6.3-mm4, or just

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm4/broken-out/ide-scsi-error-handling-fixes.patch

