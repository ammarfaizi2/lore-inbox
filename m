Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132077AbRDDUBK>; Wed, 4 Apr 2001 16:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbRDDUBA>; Wed, 4 Apr 2001 16:01:00 -0400
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:33810 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S132077AbRDDUAo>; Wed, 4 Apr 2001 16:00:44 -0400
Date: Wed, 4 Apr 2001 22:00:00 +0200 (CEST)
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: <linux-kernel@vger.kernel.org>
Subject: /dev/loop0 over lvm... leading to d-state :-(
Message-ID: <Pine.LNX.4.30.0104042152490.1183-100000@janus.txd.hvrlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fyi, loop devices over lvm LV's dont work for me...

I've tested with 2.4.3final (and some other 2.4.3 derivates) and two
lvm'ized partitions with a size of about 1gig each; mke2fs
just goes into D-state and stays there when applying it to /dev/loop0,
running it directly on the LV-device works...

greetings,
-- 

