Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbUCJUtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbUCJUtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:49:17 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:23277 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262822AbUCJUtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:49:16 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] 2.4.x Linux Medley RAID Version 7
Date: Wed, 10 Mar 2004 20:49:15 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c2nv0b$j5$1@news.cistron.nl>
References: <200403101707.38595.bzolnier@elka.pw.edu.pl> <Pine.LNX.4.40.0403101917170.2582-100000@jehova.dsm.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1078951755 613 62.216.29.200 (10 Mar 2004 20:49:15 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.40.0403101917170.2582-100000@jehova.dsm.dk>,
Thomas Horsten  <thomas@horsten.com> wrote:
>My Medley solution for 2.6 will be completely userspace (using dm), and
>there it will be possible to "force detect" an array with non-matching PCI
>ID by passing the devices as command line arguments, unfortunately it's
>not that easy in 2.4 (the whole ataraid is a hack anyway, but a useful one
>until something better is in place).

Partitioning support was added to the MD software raid layer
in 2.6 recently. Most of it is in Linus' latest tree, though a
tiny part - boot support - is still missing. Hopefully that will
be merged before 2.6.4. I'm running a system on 2 RAID1'ed SATA disks
right now.

MD already has support for more than one type of superblock. I think
if you just add medley (or intel, or ..) support to MD you're all set.

Mike.

