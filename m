Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132625AbRDOK5N>; Sun, 15 Apr 2001 06:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132626AbRDOK5C>; Sun, 15 Apr 2001 06:57:02 -0400
Received: from s340-modem2386.dial.xs4all.nl ([194.109.169.82]:9096 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S132625AbRDOK4w>;
	Sun, 15 Apr 2001 06:56:52 -0400
Date: Sun, 15 Apr 2001 14:55:53 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: <linux-kernel@vger.kernel.org>, <linux-lvm@msede.com>
Subject: 2.4.4-pre3: lvm.c patch results in "hanging" mount or swapon
Message-ID: <Pine.LNX.4.31.0104151444130.1050-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While trying kernel 2.4.4-pre3 i found a "hanging" swapon (my swap is on
LVM), same effect for "mount -a". 2.4.3 works properly.

I found ./drivers/md/lvm.c is patched, and restoring the lvm.c from 2.4.3
resulted in normal operation.

I Found LVM/0.9.1_beta7 makes some notes about the patch, so i tried that
(beta7), but no luck, only 2.4.3:lvm.c worked ok.

Greatings,

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

