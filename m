Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTFTOjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTFTOjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:39:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1921 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262331AbTFTOjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:39:43 -0400
Date: Fri, 20 Jun 2003 10:55:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Thomas Frase <thomas.frase@ist-einmalig.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: root shell exploit still working in kernel 2.4.21
In-Reply-To: <004d01c33738$7031e440$0200a8c0@brainbug>
Message-ID: <Pine.LNX.4.53.0306201054300.6559@chaos>
References: <004d01c33738$7031e440$0200a8c0@brainbug>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003, Thomas Frase wrote:

> hello!
>
> the problem:
> i tried an exploit (url given below) with debian woody kernel 2.4.18
> and self compiled kernel 2.4.21 resulting in a root shell.
>
> exploit code url: (found via google)
> http://isec.pl/cliph/isec-ptrace-kmod-exploit.c
>
> as described in the source the exploit uses the well known ptrace bug
> which i thought was fixed in kernel 2.4.21.
>
> i don't know why it still works or how to fix it. i told someone people
> in #debian.de (quakenet) about the results of the exploit and they
> asked me to post a bug report here.

The binary is 4755 (SUID!) What do you expect. Delete it and
recompile from a non-root account.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

