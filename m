Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVC3Nsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVC3Nsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 08:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVC3Nsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 08:48:52 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:1924 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261894AbVC3Nsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 08:48:51 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Accessing data structure from kernel space
To: linux lover <linux_lover2004@yahoo.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 30 Mar 2005 14:27:13 +0200
References: <fa.kvq30up.1h3mr8j@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DGcHz-0001Tk-NF@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux lover <linux_lover2004@yahoo.com> wrote:

>        I successfully added linked list data structure
>   in kernel in header file. Write a C source file and
> add it to kernel directory. then write 2 system calls
> that read and write to linked list from user space
> through that syscalls.
>        recompile kernel. Now able to read/write that
> linked list.
>        I want to write user data in that linked list
> and allow kernel to use that info in linked list. Is
> my approach to send data from user to kernel  and
> store there as long as OS is not rebooted is right?

- A linked list is bad for random access to large amounts of data.
  Why is a linked list suitable for your data?
- Did you think about SMP races?
- Why does it need to be in the kernel? Could a daemon do the job?
- to be continued
