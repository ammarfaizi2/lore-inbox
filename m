Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTEULSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 07:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTEULSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 07:18:43 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:64783 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S262033AbTEULSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 07:18:42 -0400
Message-Id: <200305211122.h4LBMsu10591@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Mark Dascher <strogian@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: rootfs and /dev/root
Date: Wed, 21 May 2003 14:29:10 +0300
X-Mailer: KMail [version 1.3.2]
References: <20030521011420.57175.qmail@web40805.mail.yahoo.com>
In-Reply-To: <20030521011420.57175.qmail@web40805.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 May 2003 04:14, Mark Dascher wrote:
> I'm curious about the two entries in /proc/mounts:
> rootfs and /dev/root.  Although I don't have much
> experience with this, I've looked through some of the
> kernel source code (e.g. fs/namespace.c or
> init/do_mounts.c).  All I can come up with (actually,
> this is pretty much what I thought before I looked at
> any code) is that rootfs is purely a kernel-generated
> filesystem.  The kernel creates the /dev/root device
> there, and then mounts /dev/root at / (replacing
> rootfs).

Yes that's what happens. Guys are planning to be able to
*really* umount real (disk-based) root fs someday
and continue halt/reboot sequence using files (scripts etc)
on this virtual rootfs.

So there will be both 'early userspace' and 'late userspace' ;)

IMHO.
--
vda
