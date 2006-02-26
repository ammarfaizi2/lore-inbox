Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWBZWux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWBZWux (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWBZWux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:50:53 -0500
Received: from 26.mail-out.ovh.net ([213.186.42.179]:25553 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP
	id S1751421AbWBZWuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:50:52 -0500
Date: Sun, 26 Feb 2006 23:50:40 +0100
From: col-pepper@piments.com
To: linux-kernel@vger.kernel.org
Subject: o_sync in vfat driver
References: <op.s5cj47sxj68xd1@mail.piments.com> <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com> <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com> <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com>
Message-ID: <op.s5lq2hllj68xd1@mail.piments.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
In-Reply-To: <op.s5kzao2jj68xd1@mail.piments.com>
User-Agent: Opera M2/8.51 (Linux, build 1462)
X-Ovh-Remote: 213.103.54.253 (d213-103-54-253.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OMG what do I have to do to post here? 10th attempt.
{part2}

Here is a non-exhaustive list of typical devices types requiring fat vfat
support:

fd ide-hd scsi-hd usb-hd cdrom usb-hd usb-handheld (iPod, iRiver etc)
usb-flash (usbsticks, cameras, some music devices.)

IIRC the sync mount option for vfat is ignored for file systems >2G, this
effectively (and probably intentionally) excludes nearly all hd partitions
and iPod type devices.

sync does not have any meaning for CD DVD media.
