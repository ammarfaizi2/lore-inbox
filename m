Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTLQJjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 04:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbTLQJjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 04:39:07 -0500
Received: from mlf.linux.rulez.org ([192.188.244.13]:57101 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S263846AbTLQJjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 04:39:05 -0500
Date: Wed, 17 Dec 2003 10:33:49 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: linux-kernel@vger.kernel.org
Cc: roman@rs-labs.com
Subject: Re: Any workaround for mounting an image file (with loop device)
 which resides on NTFS?
Message-ID: <Pine.LNX.4.21.0312171024070.12837-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Scenario: I placed one disk image (image.dd) on a NTFS volume (it's
> the only partition where I have some available space) and my idea was
> to first mount NTFS partition as /mnt/ntfs, and afterwards mounting
> /mnt/ntfs/image.dd (ext3) with loop device.
>
> I'm getting the following error at the second mount command:
> ioctl: LOOP_SET_FD: Invalid argument

Only the rewritten (new, version 2) ntfs driver supports this, see for more

	http://linux-ntfs.sourceforge.net/status.html

People and some distros use loopback mount from NTFS for r/w for over a
year with the new driver. Nobody reported problems.

	Szaka

