Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbUBFBz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 20:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUBFBz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 20:55:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:54159 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264434AbUBFBz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 20:55:58 -0500
Date: Thu, 5 Feb 2004 17:57:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Good Oleg" <olecom.gnu-linux@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]: kernel BUG at mm/swapfile.c:806! (2.6)
Message-Id: <20040205175723.421db05b.akpm@osdl.org>
In-Reply-To: <E1AouoU-000Fke-00.olecom-gnu-linux-mail-ru@f6.mail.ru>
References: <E1AouoU-000Fke-00.olecom-gnu-linux-mail-ru@f6.mail.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Good Oleg"   <olecom.gnu-linux@mail.ru> wrote:
>
> PC(see below) 256Mib of RAM, linux-2.6.2, 300Mib swap file (swapon /mnt/swap/swap)
> When programs cause big memory usage i have this
> (since my 2.4.22 to 2.6.0-test11 migration):
> 
> Feb  6 02:26:27 gluon kernel: ------------[ cut here ]------------
> Feb  6 02:26:27 gluon kernel: kernel BUG at mm/swapfile.c:806!
> Feb  6 02:26:27 gluon kernel: invalid operand: 0000 [#1]
> Feb  6 02:26:27 gluon kernel: CPU:    0
> Feb  6 02:26:27 gluon kernel: EIP:    0060:[<c015c7c4>]    Tainted: PFS
> Feb  6 02:26:27 gluon kernel: EFLAGS: 00010246
> Feb  6 02:26:27 gluon kernel: EIP is at map_swap_page+0x34/0x60

Are you using the swapd daemon?

