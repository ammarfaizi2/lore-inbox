Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbTLKM6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 07:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTLKM6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 07:58:08 -0500
Received: from nefty.hu ([195.70.37.175]:9608 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S264927AbTLKM5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 07:57:50 -0500
Date: Thu, 11 Dec 2003 13:58:01 +0100 (CET)
From: Zoltan NAGY <nagyz@nefty.hu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: crypto + dm = crash
Message-ID: <Pine.LNX.4.58.0312111355500.21554@nefty.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yesterday I tried to setup a system with RAID0 + crypto + xfs + lvm2..
I've done this:
mkraid /dev/md0
losetup -e aes /dev/loop0 /dev/md0
mkfs.xfs /dev/md0
and bang, after a few secs, it crashed the kernel with just one line
(sorry, I can't copy it, it's a production server, and it's not so good
when you have to go to the coloc facility at 4am ;))
I just wanted to inform you, and probably somebody can test it...

Regards,

--
Zoltan NAGY,
Network Administrator

