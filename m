Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbUCCNvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 08:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbUCCNvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 08:51:20 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:50115 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S261854AbUCCNvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 08:51:17 -0500
To: Michael Weiser <michael@weiser.dinsnail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
In-Reply-To: <1vBuj-3YL-17@gated-at.bofh.it>
References: <1vshj-2ou-9@gated-at.bofh.it> <1vBuj-3YL-17@gated-at.bofh.it>
Date: Wed, 3 Mar 2004 14:51:14 +0100
Message-Id: <E1AyWmI-00004I-4y@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2004 11:10:11 +0100, you wrote in linux.kernel:

> Also I very much liked the automatic creation of /dev/root by devfs
> because it kept the system bootable after moves around different
> harddrives and partitions several times where I would normally have
> forgotten to adjust fstab to the new root. I poked around sysfs and proc
> a bit but can't seem to find anything that would permit me to simlute
> that behaviour with udev. Does udev perhaps already support something
> like this?

You could do that in early user-space by reading
/proc/sys/kernel/real-root-dev and setting up /dev/root from that
information.

-- 
Ciao,
Pascal
