Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTE2LUO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTE2LUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:20:10 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35208 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262171AbTE2LTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:19:33 -0400
Date: Thu, 29 May 2003 07:34:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?mounir=20tahar=20abbes?= <mtaharabbes@yahoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: help  in tcp/ip
In-Reply-To: <20030529112649.96663.qmail@web12601.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0305290732030.17525@chaos>
References: <20030529112649.96663.qmail@web12601.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003, [iso-8859-1] mounir tahar abbes wrote:

> hello
> i want to modify the tcp_sendmsg in tcp.c for linux
> kernel 2.4.3
> in order to display the message sent and compress it
> -firs: i want to read the message sent and put it in a
>  text file.
>

Get a copy of the tcpdump source-code and see how it's done.
You do __not__ read/write files inside the kernel. You use
an external process `daemon` that writes files containing
stuff that came from inside the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

