Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSLKFnN>; Wed, 11 Dec 2002 00:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSLKFnM>; Wed, 11 Dec 2002 00:43:12 -0500
Received: from mx11.dmz.fedex.com ([199.81.193.118]:1547 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S264969AbSLKFnL>; Wed, 11 Dec 2002 00:43:11 -0500
Date: Wed, 11 Dec 2002 13:49:00 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.51 ide module problem
Message-ID: <Pine.LNX.4.50.0212111337270.29848-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/11/2002
 01:50:53 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/11/2002
 01:50:55 PM,
	Serialize complete at 12/11/2002 01:50:55 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My linux/.config ...
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDE_MODES=y

System version ...
	module-init-tools-0.9.3
	linux-2.5.51

depmod will ecounter "Segmentation fault" if the ide.ko and ide-io.ps
modules are in /lib/modules/2.5.51/kernel

After "rm ide.ko ide-io.ps", depmod runs fine, but that means ide won't
load.

Thanks,
Jeff
[ jchua@fedex.com ]
