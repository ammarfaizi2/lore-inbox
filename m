Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269633AbTGJWiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbTGJWiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:38:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266526AbTGJWiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:38:50 -0400
Date: Thu, 10 Jul 2003 18:54:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Martin Sarsale <lists@runa.sytes.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 ck3 problem booting
In-Reply-To: <20030710194051.55e9e41a.lists@runa.sytes.net>
Message-ID: <Pine.LNX.4.53.0307101852100.4351@chaos>
References: <20030710194051.55e9e41a.lists@runa.sytes.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You probably compiled with a CPU type that you don't have.
Many moons ago, you could get away with that, but now there
are some pretty fatal opcodes that can get used if you claim
you have an i686, but only have a Pentinum.

On Thu, 10 Jul 2003, Martin Sarsale wrote:

> Dear all:
>
> I've downloaded 2.4.21 and patched it with con kolivas's patch v3 (patch-2.4.21-ck3.bz2). After compiling, the kernel doesn't boot:
>
> first, it uncompresses linux kernel and after "Ok, booting the kernel" it hangs there forever.
> Im an experienced linux user but I've no idea how to track the source of a problem at this boot stage.
>
> I've compiled it with gcc version 3.3.1 20030626 (Debian prerelease) and Im sending you my config.
>
> Thanks in advance
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

