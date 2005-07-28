Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVG1JMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVG1JMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVG1JMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:12:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:461 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261379AbVG1JMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:12:00 -0400
Date: Thu, 28 Jul 2005 02:10:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2
Message-Id: <20050728021048.53bf56c9.akpm@osdl.org>
In-Reply-To: <42E89F4C.5010507@reub.net>
References: <fa.gdh870p.1pmsr31@ifi.uio.no>
	<42E89F4C.5010507@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> On 27/07/2005 9:45 a.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm2/
> > 
> > 
> > - Lots of fixes and updates all over the place.  There are probably over 100
> >   patches here which need to go into 2.6.13.
> > 
> > - A reminder that -mm commit activity may be monitored by subscribing to
> >   the mm-commits list.  Do
> > 
> > 	echo subscribe mm-commits | mail majordomo@vger.kernel.org
> > 
> 
> Also seeing this during boot-up:

This was happening in earlier -mm's was it not?

> last sysfs file:

grr, I need to fix that.

>   [<c0103983>] show_stack+0x94/0xca
>   [<c0103b37>] show_registers+0x165/0x1f9
>   [<c0103d5d>] die+0x108/0x183
>   [<c0318c3a>] do_page_fault+0x1ea/0x63d
>   [<c0103657>] error_code+0x4f/0x54
>   [<c018b5c3>] fill_read_buffer+0x2e/0x74
>   [<c018b6fe>] sysfs_read_file+0x46/0x76

some dud sysfs file.

