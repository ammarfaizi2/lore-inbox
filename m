Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbRCBKSL>; Fri, 2 Mar 2001 05:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRCBKSC>; Fri, 2 Mar 2001 05:18:02 -0500
Received: from [62.172.234.2] ([62.172.234.2]:23092 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S130386AbRCBKRo>;
	Fri, 2 Mar 2001 05:17:44 -0500
Date: Fri, 2 Mar 2001 10:17:37 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac8
Message-ID: <Pine.LNX.4.21.0103021017050.1338-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Alan Cox wrote:
> 2.4.2-ac8
> o	Stop two people claiming the same misc dev id	(Philipp Rumpf)

is this what has broken misc devi registration on my machine? I have two
misc devices -- microcode and psaux -- now (ac8) I get none, /proc/misc is
empty. Also, on boot gpm generates an "oops" from gpm.c(968) saying
"/dev/mouse: No such device"

So, ac8 has two problems for me:

1. /proc/cpuinfo shows wrong info about bus (claims to be overclocked) --
I will get back to you with the info you requested shortly

2. misc device registration is broken.

Regards,
Tigran


