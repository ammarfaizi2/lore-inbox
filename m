Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWDTPrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWDTPrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWDTPrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:47:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:25490 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751042AbWDTPrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:47:22 -0400
X-Authenticated: #14349625
Subject: Re: Which process is associated with process ID 0 (swapper)
From: Mike Galbraith <efault@gmx.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Mikado <mikado4vn@gmail.com>, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com>
References: <4447A19E.9000008@gmail.com>
	 <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 17:48:23 +0200
Message-Id: <1145548103.15012.3.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 11:30 -0400, linux-os (Dick Johnson) wrote:

> This must be a trick question. Linux is not VAX/VMS. There is no
> swapper process. Check in /proc. Processes start at 1. Even
> kernel threads have PIDs greater than 1.

include/linux/init_task.h
        .pgd            = swapper_pg_dir,
        .comm           = "swapper",

You don't make enough nuclear powered kernels :)

	-Mike

