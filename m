Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWGXXT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWGXXT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 19:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWGXXT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 19:19:56 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:11137 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932320AbWGXXT4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 19:19:56 -0400
Subject: loopback blockdevice driver partition support
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 01:19:52 +0200
Message-Id: <1153783192.11477.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.. i was wondering if someone may have done some work to make the
loopback driver support partitions..

i found that a guy had written a nice script that used sfdisk and
dmsetup to use device mapper on a loopback image of an entire harddrive
(using DOS partition table ofcourse) to create device mapper
"partitions".

though this doesent quite meet my requirements, as i need to read an
image of an amiga disk..

therefore it would seem like a good idea to make the loopback driver
work with linux's partition table support, since it already supports
this.

if anyone has done some work in this, please mail me, and possibly i can
continue it if wanted. just want to know if anyone already has done
something like it before i try at it myself..


mvh.
Kasper Sandberg

