Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130544AbRCIQvT>; Fri, 9 Mar 2001 11:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRCIQvJ>; Fri, 9 Mar 2001 11:51:09 -0500
Received: from www.wen-online.de ([212.223.88.39]:65030 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130544AbRCIQvB>;
	Fri, 9 Mar 2001 11:51:01 -0500
Date: Fri, 9 Mar 2001 17:50:22 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Alexander Viro <viro@math.psu.edu>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103091449580.6037-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0103091742360.6688-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Mike Galbraith wrote:

> You must exec a shell (or something) chrooted to your mounted harddisk
> to un-busy the old root and then pivot_root/unmount that old root.  I
> tested this, and all is well.

This came out a little backassward.. pivot_root then chroot/unmount.

