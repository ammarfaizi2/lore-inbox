Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUKSCFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUKSCFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUKSCD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 21:03:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:3035 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261193AbUKSCAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 21:00:50 -0500
Date: Thu, 18 Nov 2004 18:00:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2 cannot boot system.
Message-Id: <20041118180035.1e1f87a3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0411180557030.31405@p500>
References: <Pine.LNX.4.61.0411180557030.31405@p500>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>
> System: Dell Optiplex GX1p (500MHZ)
>  When I boot the 2.6.10-rc2 kernel from LILO, the machine reboots.

Does anything at all come out on the console first?

If so, it'd be interesting to add `initcall_debug' to the kernel boot
parameters and capture the output.

Also, double-check your .config.  Doing things like selecting the wrong CPU
type can cause unpleasant things to happen.

