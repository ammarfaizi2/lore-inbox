Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267056AbUBMPd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267057AbUBMPd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:33:56 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:54505 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S267056AbUBMPdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:33:55 -0500
Date: Fri, 13 Feb 2004 10:31:54 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: Konstantin Kudin <konstantin_kudin@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange boot with multiple identical disks
In-Reply-To: <1076616510.16375.25.camel@shaggy.austin.ibm.com>
Message-ID: <Pine.GSO.4.33.0402131029290.28488-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Dave Kleikamp wrote:
>Redhat mounts the file systems by label.  I believe if you modify
>/boot/grub/grub.conf and /etc/fstab to use the device names (/dev/hda*)
>instead of LABEL=/, etc., then it should boot properly.  After wiping
>out hdc, you can change them back to the way they were.

It'll boot properly ONCE.  Redhat (in their ever increasing stupidity)
converts fstab to labels on every boot.  Remove kudzu and this won't
happen anymore. (or mark /etc/fstab as immutable and then NOTHING can
change it.)

--Ricky


