Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269963AbTGPBBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269967AbTGPBBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:01:19 -0400
Received: from quechua.inka.de ([193.197.184.2]:30132 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S269963AbTGPBBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:01:18 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: LVM, snapshots and Linux 2.4.x
In-Reply-To: <20030715223342.GH26404@corp.vendio.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19catr-0002rI-00@calista.inka.de>
Date: Wed, 16 Jul 2003 03:16:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030715223342.GH26404@corp.vendio.com> you wrote:
> if I turn off HIGHIO, the lvcreate command completes successfully, but
> the snapshot is unmountable. 

kvm was segfaulting for me with xfs if the snapsht volume gets full, but I
think this is fixed.

What filesystem do you had on the snapshot volume? Depending on the
filesystem, you may need to mount it without journal replay, or with
ignoring duplicate uuids.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
