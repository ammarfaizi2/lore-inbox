Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262307AbREXVOK>; Thu, 24 May 2001 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbREXVNx>; Thu, 24 May 2001 17:13:53 -0400
Received: from c122070.upc-c.chello.nl ([212.187.122.70]:9476 "EHLO
	c122070.upc-c.chello.nl") by vger.kernel.org with ESMTP
	id <S262297AbREXVNQ>; Thu, 24 May 2001 17:13:16 -0400
Message-ID: <3B0D95E1.518EB8B7@chello.nl>
Date: Fri, 25 May 2001 01:14:41 +0200
From: Harm Verhagen <h.verhagen@chello.nl>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops on booting 2.4.4
In-Reply-To: <mailman.990573660.4187.linux-kernel2news@redhat.com> <200105230307.f4N378P19951@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> > May 23 02:46:24 localhost kernel: Process kudzu (pid: 219,
> > stackpage=c7845000)
> > May 23 02:46:24 localhost kernel: Stack: c12607e0 00000400 00000400
> > c73aa000 c122a060 c122a05c c122a058 c88fbb20
> > May 23 02:46:24 localhost kernel:        000003f1 000003f1 c014ab80
> > c73aa3f1 c7845f9c 00000000 00000400 ffffffea
> > May 23 02:46:24 localhost kernel:        c7f43f60 00000400 bffff4b8
> > c7f2e220 c12607e0 00000000 00000000 c73aa000
> > May 23 02:46:24 localhost kernel: Call Trace: [<c88fbb20>]
> > [proc_file_read+184/464] [sys_read+142/196] [system_call+51/56]
> > May 23 02:46:24 localhost kernel: Call Trace: [<c88fbb20>] [<c014ab80>]
> > [<c012e83e>] [<c0106aeb>]
>
> A module deregistered incorrectly, or has a race between
> post-load activities and unload. One way or another it left
> a dangling proc entry.
>
> The oops does not provide off-stack information, so it's impossible
> to tell what particular modules is the culprit.
>
> > May 23 02:46:24 localhost kernel: hub.c: USB new device connect on
> > bus1/2, assigned device number 2
> > May 23 02:46:24 localhost kernel: usb.c: USB device 2 (vend/prod
> > 0x4a9/0x2204) is not claimed by any active driver.
>
> What is this thing you have on USB? Try to run without it.
>
> -- Pete

It's a canon usb scanner.
running with or without it does not make any difference.

kind regards,
Harm

