Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUBFVjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbUBFVjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:39:41 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:17937 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265959AbUBFVhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:37:10 -0500
Date: Fri, 6 Feb 2004 22:37:08 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Issues with linux-2.6.2
Message-ID: <20040206223708.A2992@pclin040.win.tue.nl>
References: <20040206212205.46151.qmail@web40501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040206212205.46151.qmail@web40501.mail.yahoo.com>; from alex14641@yahoo.com on Fri, Feb 06, 2004 at 01:22:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 01:22:05PM -0800, Alex Davis wrote:

> I have a few issues with 2.6.2. Ths first issue is when upgrading from 2.4, I had to create 
> the symlinks:
> 
>    ln -s /usr/include/asm /usr/src/linux/include/asm-i386
>    ln -s /usr/include/asm-generic /usr/src/linux/include/asm-generic
> 
> This requirement was not mentioned in any documentation I could find.

No, because it is wrong. A very unwise thing to do.

> The second issue is when trying to build util-linux-2.11z I get the following error:
> 
> cc -pipe -O2 -mcpu=i486 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes
> -Wstrict-prototypes -I/usr/include/ncurses -DNCH=0   -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\"
> -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\"
> -DLOCALEDIR=\"/usr/share/locale\" -O2  -s  blockdev.c   -o blockdev
> blockdev.c:70: error: parse error before '[' token
> blockdev.c:70: error: initializer element is not constant

And this is your punishment.

Andries
