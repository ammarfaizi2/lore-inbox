Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbUL1NZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUL1NZR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 08:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUL1NZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 08:25:16 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:29611 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261168AbUL1NZK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 08:25:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jfm4fpykrB/YIpP2NCeLayp/d/sBSOnWos5939xoB1XLToML3P9q4thRjy0o3RBXQ8ZwVg6nu/dFw0f1mJ0C16oE1OYFX7d/savyu51VDcwvd+/SgsBl2jZDchuaCxuQi5uBVc2sWVqDQu4wXZHN8bOOaeoW3G0WXWRK1mfZsBI=
Message-ID: <d5a95e6d0412280525f98268e@mail.gmail.com>
Date: Tue, 28 Dec 2004 10:25:06 -0300
From: Diego <foxdemon@gmail.com>
Reply-To: Diego <foxdemon@gmail.com>
To: Michelle Konzack <linux4michelle@freenet.de>
Subject: Re: About NFS4 in kernel 2.6.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041228002504.GD18869@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <d5a95e6d04122711183596d0c8@mail.gmail.com>
	 <20041227192508.GC18869@freenet.de>
	 <d5a95e6d04122711355a0a9b04@mail.gmail.com>
	 <20041228002504.GD18869@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michelle,
you wrote:
> Are you sure, it is not there ?
> You will find the "sunrpc" module in
> 
> /lib/modules/2.6.9/kernel/net/sunrpc/sunrpc.ko
>              ^^^^^
>     Your Kernelversion here

That was really not there, no sunrpc directory nor sunrpc.ko, I copy
from another kernel and now i'll try. About using .config from /boot
my friend tryied but it doesn´t work. Shows kernel panic, but I' ll
try it myself now.

> | # Network File Systems
> | #
> | CONFIG_NFS_FS=y
> | CONFIG_NFS_V3=y
> | CONFIG_NFS_V4=y
> | CONFIG_NFS_DIRECTIO=y
> | # CONFIG_ROOT_NFS is not set
> | CONFIG_NFSD=y
> | CONFIG_NFSD_V3=y
> | CONFIG_NFSD_V4=y
> | CONFIG_NFSD_TCP=y
> | CONFIG_LOCKD=y
> | CONFIG_LOCKD_V4=y
> | CONFIG_SUNRPC=y

My .config is like yours, now it's the perfect time to pray to lord.
Thanks for all help.
