Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVFZOLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFZOLN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 10:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVFZOLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 10:11:13 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:27406 "EHLO
	mail.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S261232AbVFZOLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 10:11:08 -0400
Date: Sun, 26 Jun 2005 16:11:06 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Christian Trefzer <ctrefzer@web.de>
Cc: "Darryl L. Miles" <darryl@netbauds.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
Message-ID: <20050626141106.GA12223@shuttle.vanvergehaald.nl>
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org> <42BE7E38.9070703@netbauds.net> <42BE98C5.1070102@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BE98C5.1070102@web.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 02:00:05PM +0200, Christian Trefzer wrote:
> Darryl L. Miles schrieb:
> >Andrew Morton wrote:
> 
> [snip]
> 
> >Found the thread:   
> >http://www.ussg.iu.edu/hypermail/linux/kernel/0506.0/1556.html
> >
> >
> >This works for me:
> >
> 
> [snip]
> 
> Thanks, but still no go, as I am using Gentoo and a totally bloated 
> self-grown glibc initramfs environment. Whenever I boot 2.6.11.12, there 
> is no problem whatsoever about modprobe returning before device nodes 
> are created. Any ideas? I changed udev versions back and forth between 
> 058 and 056, did not make any difference either...

Well, I'm running Gentoo Linux x86_64 with a 2.6.12 kernel.
I didn't experience any problems. I use initrd because most
filesystems are located on LVM partitions.
I build my kernel with the following command:

	genkernel --no-mrproper --oldconfig --lvm2 --udev all

Work like a charm.
Regards,
Toon.
