Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275734AbRJAXvk>; Mon, 1 Oct 2001 19:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275731AbRJAXvd>; Mon, 1 Oct 2001 19:51:33 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:44036 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S275727AbRJAXvV>; Mon, 1 Oct 2001 19:51:21 -0400
Message-ID: <3BB900D1.5A5DB657@osdlab.org>
Date: Mon, 01 Oct 2001 16:48:33 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jordan Breeding <ledzep37@home.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing dmesg buffer size?
In-Reply-To: <3BB90039.E551000C@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding wrote:
> 
> What kernel parameter do I need to modify in the source to allow a
> larger dmesg buffer?  I have a lot of boot messages and I currently
> loose about 10-20 lines immediately and they can not even be seen in
> /var/log/dmesg because that file gets dumped after those lines are
> already gone.  Thanks to anyone who can help.

That would be a #define of LOG_BUF_LEN in linux/kernel/printk.c.

Be sure to keep it a power of 2.

There have been several patch files for this on the kernel
mailing list, but it's easy enough to DIY.

~Randy
