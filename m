Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264465AbUESRZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbUESRZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUESRZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 13:25:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14464 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264465AbUESRZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 13:25:10 -0400
Date: Wed, 19 May 2004 13:25:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: sai narasimhamurthy <sai_narasi@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: source changes without kernel re-compiling
In-Reply-To: <20040519171610.67026.qmail@web90009.mail.scd.yahoo.com>
Message-ID: <Pine.LNX.4.53.0405191322410.1078@chaos>
References: <20040519171610.67026.qmail@web90009.mail.scd.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2004, sai narasimhamurthy wrote:

> Hi ,
> I am working with the Linux networking source code for
> the first time.
> I am working with the file tcp.c in
> /usr/src/linux/net/ipv4 . Everytime I make a small
> change, I recompile the kernel. Is there any way to
> get the changes in tcp.c (or any file in /ipv4 , for
> that matter) reflected without kernel re-compiling, so
> that it saves time?
> Sai
>

You modify the source, then you return to the top-level
directory and execute `make bzImage` or `make modules`
if you are modifying a module. Only the file(s) that
you modify will get compiled. The final link, of course,
gets done. But that's only a second or two.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


