Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbTDNTum (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbTDNTum (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:50:42 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:38925 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263820AbTDNTul convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:50:41 -0400
Date: Mon, 14 Apr 2003 22:02:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <Pine.LNX.4.44.0304141249130.32035-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304142154130.5042-100000@serv>
References: <Pine.LNX.4.44.0304141249130.32035-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Apr 2003, Linus Torvalds wrote:

> Because a kernel that cannot be used with old filesystems is a _useless_ 
> kernel as far as I'm concerned.
> 
> Backwards compatibility is _important_. It's HUGELY important. It's just
> possibly more important than anything else the kernel ever can do.
> 
> And new kernels need to be able to seamlessly boot into a disk-image that 
> may still need to be used from an old kernel. Without any magic going on.
> 
> We can discontinue the old IDE/SCSI majors one or two stable releases 
> _after_ we've switched over to a global "disk major". In other words, 
> that's about five years down the line after you shouldnä't have to care 
> any more.

I agree and as long as you don't tell the kernel otherwise it will accept 
the old numbers, but if you start to support larger minor numbers now, you 
will have to support them even longer.

bye, Roman

