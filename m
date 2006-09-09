Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWIIM65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWIIM65 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 08:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWIIM65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 08:58:57 -0400
Received: from alpha.polcom.net ([83.143.162.52]:23495 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S932145AbWIIM6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 08:58:54 -0400
Date: Sat, 9 Sep 2006 14:58:47 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] linux/magic.h for magic numbers
In-Reply-To: <20060909110245.GA9617@havoc.gtf.org>
Message-ID: <Pine.LNX.4.63.0609091453200.29522@alpha.polcom.net>
References: <20060909110245.GA9617@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sep 2006, Jeff Garzik wrote:
> An IRC discussion sparked a memory:  most filesystems really don't
> need to put anything at all in include/linux.  Excluding API-ish
> filesystems like procfs, just about the only filesystem symbols that
> get exported outside of __KERNEL__ are the *_SUPER_MAGIC symbols,
> and similar symbols.
>
> After seeing the useful attributes of linux/poison.h, I propose a
> similar linux/magic.h.

But... if some patch changes this file (like adding new magic symbol) it 
will cause large part of the kernel to rebuild without any good reason. 
No?


Grzegorz Kulewski

