Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbUK2VWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUK2VWC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUK2VWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:22:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:4330 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261792AbUK2VWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:22:00 -0500
Date: Mon, 29 Nov 2004 13:26:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: bobl <bobl@turbolinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is this a bug of vt_ioctl ??
Message-Id: <20041129132615.0564c013.akpm@osdl.org>
In-Reply-To: <41AAD28B.2070301@turbolinux.com>
References: <41AAD28B.2070301@turbolinux.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bobl <bobl@turbolinux.com> wrote:
>
> we can see in the case PIO_UNIMAPCLR, One parameter of con_clear_unimp 
> is  "fg_console"! it's current tty!  In the implement of 
> do_unimap_ioctl(), use "fg_console" too! Use "console" will be right!

This was fixed almost a year ago.

> 
> The attachment is a patch against 2.6.8.1.

Maybe you're looking at a 2.4 kernel.
