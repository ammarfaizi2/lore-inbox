Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266740AbUHUQCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266740AbUHUQCy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 12:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266731AbUHUQCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 12:02:54 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:54470 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266727AbUHUQCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 12:02:50 -0400
Subject: Re: 2.6.8.1-mm3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <200408211443.i7LEh3aR024466@harpo.it.uu.se>
References: <200408211443.i7LEh3aR024466@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 21 Aug 2004 12:02:24 -0400
Message-Id: <1093104149.2092.165.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 10:43, Mikael Pettersson wrote:
> On Fri, 20 Aug 2004 03:19:19 -0700, Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/
> ...
> > bk-scsi.patch
> 
> This one is broken. It causes the kernel to emit a bogus
> "program $PROG is using a deprecated SCSI ioctl, please convert it to SG_IO"
> message whenever user-space open(2)s a SCSI block device, even
> though user-space never did any ioctl() on it.

A simple open of /dev/sda from userland doesn't exhibit this behaviour
for me.  What sort of device is this?  And what is the program?

James


