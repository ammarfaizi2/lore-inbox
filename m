Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbULPTwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbULPTwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbULPTwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:52:23 -0500
Received: from brown.brainfood.com ([146.82.138.61]:42677 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262020AbULPTwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:52:12 -0500
Date: Thu, 16 Dec 2004 13:52:10 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Neil Conway <nconway_kernel@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 3TB disk hassles
In-Reply-To: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.58.0412161351540.2173@gradall.private.brainfood.com>
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Neil Conway wrote:

> Howdy...
>
> After much banging of heads on walls, I am throwing in the towel and
> asking the experts ;-) ... To cut a long story short:
>
> Is it possible to make a 3TB disk work properly in Linux?
>
> Our "disk" is 12x300GB in RAID5 (with 1 hot-spare) on a 3ware 9500-S12,
> so it's actually 2.7TiB ish.  It's also /dev/sda - i.e., the one and
> only disk in the system.
>
> Problems are arising due to the 32-bit-ness of normal partition tables.
>  I can use parted to make a 2.7TB partition (sda4), and
> /proc/partitions looks fine until a reboot, whereupon the top bits are
> lost and the big partition looks like a 700GB partition instead of a
> 2.7TB one; this is a bad thing ;-)
>
> I've had my hopes raised by GPT, but after more reading it appears this
> doesn't work on vanilla x86 PCs.
>
> Tips gratefully received.

Maybe use LVM on the raw device?
