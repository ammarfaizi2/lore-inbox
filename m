Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUGIVik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUGIVik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUGIVik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:38:40 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:42056 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S263574AbUGIVie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:38:34 -0400
Message-ID: <c26fd828040709143843b3143f@mail.gmail.com>
Date: Fri, 9 Jul 2004 14:38:26 -0700
From: Qiuyu Zhang <qiuyu.zhang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: strange about copy_from_user
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am working on writing a module driver.

I am trying to use API copy_from_user to copy a bunch of memory from
user space to kernel space. I write a ioctl function to register the
pointer of the memory to kernel. And in the ioctl function I can use
copy_from_user to get the correct data, but the strange thing is that
when I use copy_from_user in other kernel function such as
dev_hard_xmit function , I cannot
get the correct result. I don't konw what the reason is . Thx.
