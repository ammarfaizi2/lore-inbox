Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSGAVhz>; Mon, 1 Jul 2002 17:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSGAVhz>; Mon, 1 Jul 2002 17:37:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17670 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316530AbSGAVhy>;
	Mon, 1 Jul 2002 17:37:54 -0400
Message-ID: <3D20CBD7.BC184F53@zip.com.au>
Date: Mon, 01 Jul 2002 14:38:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bongani <bonganilinux@mweb.co.za>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EXT3 errors
References: <1025551456.1587.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani wrote:
> 
> Hi
> 
> Does anyone what cause's these message. I have a 41M messages file
> because of the.
> 
> Jul  1 04:02:14 localhost kernel: EXT3-fs error (device ide0(3,70)):
> ext3_new_block: Allocating block in system zone - block = 32802

Your filesystem is wrecked.  Did you get some I/O errors?

You need to unmount it, run `e2fsck -f' and fix it up.

-
