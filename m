Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275723AbRJAXzU>; Mon, 1 Oct 2001 19:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275719AbRJAXzL>; Mon, 1 Oct 2001 19:55:11 -0400
Received: from www.transvirtual.com ([206.14.214.140]:23823 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S275723AbRJAXy4>; Mon, 1 Oct 2001 19:54:56 -0400
Date: Mon, 1 Oct 2001 16:55:13 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Jordan Breeding <ledzep37@home.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing dmesg buffer size?
In-Reply-To: <3BB90039.E551000C@home.com>
Message-ID: <Pine.LNX.4.10.10110011650280.8135-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What kernel parameter do I need to modify in the source to allow a
> larger dmesg buffer?  I have a lot of boot messages and I currently
> loose about 10-20 lines immediately and they can not even be seen in
> /var/log/dmesg because that file gets dumped after those lines are
> already gone.  Thanks to anyone who can help.

No command line paramter. Go into linux/kernel/printk.c and increase the
value of LOG_BUF_LEN. It must be a power of two.

