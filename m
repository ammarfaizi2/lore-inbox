Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129142AbRBSJ2z>; Mon, 19 Feb 2001 04:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbRBSJ2p>; Mon, 19 Feb 2001 04:28:45 -0500
Received: from quechua.inka.de ([212.227.14.2]:13092 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129142AbRBSJ2f>;
	Mon, 19 Feb 2001 04:28:35 -0500
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel executation from ROM
In-Reply-To: <01e701c09a2a$21e789a0$bba6b3d0@Toshiba>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14UmcV-0000Ki-00@sites.inka.de>
Date: Mon, 19 Feb 2001 10:28:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01e701c09a2a$21e789a0$bba6b3d0@Toshiba> you wrote:
> I see . The biggest negative point of running kernel from ROM is that ROM
> speed is slow :(

Well, normally you use the ROM only as a "boot device". You copy the Kernel
into RAM and run it. Ram is not more expensive than ROM :)

What is your Reason for keeping the Kernel in ROM? Security? Do you have a
special limited Device? In that case you might want to look at the embedded
Linux Versions which run without MMU. Those might even have a decent ROM
Performance (compared to RAM).

Greetings
Bernd
