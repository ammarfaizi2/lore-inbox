Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUIAWBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUIAWBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268177AbUIAVy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:54:57 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:55651 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S268168AbUIAVuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:50:14 -0400
Date: Thu, 2 Sep 2004 00:53:14 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901215314.GC26044@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1094052981.431.7160.camel@cube> <52vfey0ylu.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52vfey0ylu.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Roland Dreier (roland@topspin.com) "Re: f_ops flag to speed up compatible ioctls in linux kernel":
>     Albert> Per-command parameters included?
> 
>     Albert> People really do want private syscalls. An ioctl is that,
>     Albert> in a namespace defined by the file descriptor. So ioctl()
>     Albert> provides local scope to something that would otherwise be
>     Albert> global.
> 
> Yes, this is exactly right.  One issue raised by this thread is that
> the ioctl32 compatibility code only allows one compatibility handler
> per ioctl number.  It seems that this creates all sorts of
> possibilities for mayhem because it makes the ioctl namespace global
> in scope in some situations.  Does anyone have any thoughts on if/how
> this should be addressed.
> 

Thats what my original patch attempts to address
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0409.0/0025.html
What do you think?

