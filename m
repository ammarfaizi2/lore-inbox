Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTD2WM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTD2WM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:12:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48782 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261326AbTD2WMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:12:25 -0400
Date: Tue, 29 Apr 2003 18:24:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pawan Deepika <pawan_deepika@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'tainting kernel' problem in linux-2.4.18
In-Reply-To: <20030429215318.27252.qmail@web41608.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0304291822040.6694@chaos>
References: <20030429215318.27252.qmail@web41608.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Apr 2003, Pawan Deepika wrote:

>
> Hi,
>
>  I am trying LKM with linux-2.4.18. I have a problem
> here. When I load the module using 'insmod' command,
> module gets loaded but I get following error
>
> ------------------------------------------------------
> /sbin/insmod ./hello.o
> Warning: loading ./hello.o will taint the kernel: no
> license
>   See http://www.tux.org/lkml/#export-tainted for
> information about tainted modules
> Module hello loaded, with warnings
> ----------------------------------------------------
>
> Can anyone tell me why I am getting this problem and
> what is the impact of this error while module is
> running in kernel.
>
> Thanks in advance.
>
> Regards,
> Deepika
>
The module police now require you to put something like:
MODULE_LICENSE("Spellman Empire") (or something like that)
in your module.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

