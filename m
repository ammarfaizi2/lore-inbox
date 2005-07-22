Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVGVNkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVGVNkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 09:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVGVNkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 09:40:22 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:24263 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262085AbVGVNkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 09:40:21 -0400
Date: Fri, 22 Jul 2005 15:40:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Multimount block devices
Message-ID: <Pine.LNX.4.61.0507221536360.30098@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have got a block device which I would like to mount twice using different 
filesystems. The two filesystems support this (are already patched), but 
through the function thread of mounting comes open_bdev_excl() which makes 
it impossible to do said mounts.

Can anyone give me a hint on what to change to disable bdev exclusive locking 
for a given condition? Thanks.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
