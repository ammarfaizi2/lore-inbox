Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130320AbRCETER>; Mon, 5 Mar 2001 14:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130324AbRCETEG>; Mon, 5 Mar 2001 14:04:06 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:36873 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S130320AbRCETED>; Mon, 5 Mar 2001 14:04:03 -0500
Date: Mon, 5 Mar 2001 11:03:56 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loop stuck in -D state
In-Reply-To: <Pine.LNX.3.95.1010305133108.884B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.31ksi3.0103051059110.7347-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Richard B. Johnson wrote:

> The initial RAM disk image is created using the loop device. You
> can create a RAM disk image for initrd by using the ram device.
> However, that doesn't work once the system has been booted off
> it (try it, be ready for a complete hang).

So don't use ext2fs for the initial RAM disk image :)) We use romfs in KSI
Linux instead for a very long time and we're quite happy with it. As a
matter of fact, we have all filesystems (including ext2fs) and all block
devises (including IDE) in modules. The only things built-in are initial RAM
disk and romfs...

One don't need a loopback device to create a romfs image...

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV, 89014

