Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbWBNJCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbWBNJCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWBNJCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:02:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932376AbWBNJCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:02:09 -0500
Date: Tue, 14 Feb 2006 01:01:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mao, Bibo" <bibo.mao@intel.com>
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       anil.s.keshavamurthy@intel.com, yanmin.zhang@intel.com
Subject: Re: [PATCH] kretprobe instance recyled by parent process
Message-Id: <20060214010106.59306831.akpm@osdl.org>
In-Reply-To: <9FBCE015AF479F46B3B410499F3AE05B0898E1@pdsmsx405>
References: <9FBCE015AF479F46B3B410499F3AE05B0898E1@pdsmsx405>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mao, Bibo" <bibo.mao@intel.com> wrote:
>
> When kretprobe probe schedule() function, if probed process exit then
>  schedule() function will never return, so some kretprobe instance will
>  never be recycled. By this patch the parent process will recycle
>  kretprobe instance of probed function, there will be no memory leak of
>  kretprobe instance. This patch is based on 2.6.16-rc3.

The patch is extremely wordwrapped.  Please sort out your email client,
send yourself a test patch, check that it applies OK, then resend, thanks.

