Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSJCQdM>; Thu, 3 Oct 2002 12:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSJCQdL>; Thu, 3 Oct 2002 12:33:11 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26825 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261381AbSJCQdL>; Thu, 3 Oct 2002 12:33:11 -0400
Date: Thu, 3 Oct 2002 12:38:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200210031638.g93Gc4804388@devserv.devel.redhat.com>
To: Steve Mickeler <steve@neptune.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: addressing > 128 scsi discs
In-Reply-To: <mailman.1033655221.26800.linux-kernel2news@redhat.com>
References: <mailman.1033655221.26800.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a way in 2.4 to address more than 128 scsi discs ?

Official major allocation allows 256. You can take a patch from
a fresh Red Hat to do it.

Also, you can use devfs or a combo of Kurt's scsi-many and scsidev.

-- Pete
