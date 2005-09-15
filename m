Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVIOBIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVIOBIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVIOBIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:08:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:23168 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1030318AbVIOBIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:08:40 -0400
Subject: Re: devfs vs udev FAQ from the other side
From: Robert Love <rml@novell.com>
To: Mike Bell <mike@mikebell.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>
In-Reply-To: <20050915005105.GD15017@mikebell.org>
References: <20050915005105.GD15017@mikebell.org>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 21:08:38 -0400
Message-Id: <1126746518.9652.60.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 17:51 -0700, Mike Bell wrote:

> devfs advantages over udev:
> 1) devfs is smaller
>   Hey, I ran the benchmarks, I have numbers, something Greg never gave.

Actually, there are not many numbers in this email.

>   Took an actual devfs system of mine and disabled devfs from the
>   kernel, then enabled hotplug and sysfs for udev to run.  make clean
>   and surprise surprise, kernel is much bigger. Enable netlink stuff and
>   it's bigger still. udev is only smaller if like Greg you don't count
>   its kernel components against it, even if they wouldn't otherwise need
>   to be enabled. Difference is to the tune of 604164 on udev and 588466
>   on devfs. Maybe not a lot in some people's books, but a huge
>   difference from the claims of other people that devfs is actually
>   bigger.

What modern system, though, could survive without hotplug and sysfs and
netlink?  You need to have those components, you want those features,
anyhow.

So your comparison is unrealistic.

Your user-space argument is better.  Is ndevfs not sufficient?

	Robert Love


