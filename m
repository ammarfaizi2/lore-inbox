Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264148AbTDJSIP (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 14:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTDJSIP (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 14:08:15 -0400
Received: from WARSL401PIP6.highway.telekom.at ([195.3.96.93]:36665 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id S264148AbTDJSIM (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 14:08:12 -0400
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
To: Nuno Silva <nuno.silva@vgertech.com>
Subject: Re: Linux-2.4.20 on a 4 MB Laptop
Date: Thu, 10 Apr 2003 20:19:31 +0200
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304091601.55821.dusty@violin.dyndns.org> <3E94DCA1.5020106@vgertech.com>
In-Reply-To: <3E94DCA1.5020106@vgertech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304102019.32019.dusty@violin.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 April 2003 04:53, Nuno Silva wrote:
> Hermann Himmelbauer wrote:
> > Well - anyway, the kernel boots but right stops after:
> > INIT: Entering runlevel:3
> >
> > The next line is:
> > INIT: open(/dev/console): Input/output error
> > INIT: Id "2" respawning too fast: disabled for 5 minutes
> > ...
> >
> > That's it.
>
> Maybe you striped too much and didn't include *any* console type
> (serial, vga or framebuffer)? :)

No, I thought of this - in menuconfig I use this:
[*] Virtual terminal
[*]   Support for console on virtual terminal

Moreover the exact same kernel boots in another notebook (P-II, 333 Mhz, 144MB 
Ram) - I simply put the 2.5'' Harddisk in the other Laptop.

Anyway, I'll try the following:

1) Try to get more RAM ( + 8MB, 12MB should be enough - but maybe I'll never 
get this IBM specific DRAM-cards for this old laptop.
2) Kick out ext3 - this could save more memory
3) Try init=/bin/sh and "swapon" manually
4) Use an older or memory optimized kernel

Booting with "mem=4" will probably also help with testing.

Many thanks for your helpful replies!

		Best Regards,
		Hermann

--
x1@aon.at
GPG key ID: 299893C7 (on keyservers)
FP: 0124 2584 8809 EF2A DBF9  4902 64B4 D16B 2998 93C7

