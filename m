Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162481AbWLBVPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162481AbWLBVPl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162482AbWLBVPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:15:40 -0500
Received: from 1wt.eu ([62.212.114.60]:18693 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1162481AbWLBVPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:15:40 -0500
Date: Sat, 2 Dec 2006 22:15:22 +0100
From: Willy Tarreau <w@1wt.eu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: William Estrada <MrUmunhum@popdial.com>, linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
Message-ID: <20061202211522.GB24090@1wt.eu>
References: <4571CE06.4040800@popdial.com> <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 08:07:45PM +0100, Jan Engelhardt wrote:
> >
> > I have been trying to make FC5's kernel do a boot with an NFS root file
> > system.  I see
> > the support is in the kernel(?).  I have tried this:
> >
> >> root=/dev/nfs nfsroot=10.1.1.12:/tftpboot/NFS/Root_FS
> 
> This feature is almost deprecated. One is supposed to use initramfs,
> /sbin/ip or some DHCP client, and a mount program nowadays.

But I think that there are plenty of light terminals still booting like
this which will not be able to upgrade anymore then. Even right here,
my web server (parisc) boot from the network that way. At least an
initramfs would need to be able to cope with the same syntax, otherwise
we might break some systems where it's not even easy to change those
info in the boot loader.

Willy

