Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTKJUFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 15:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTKJUFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 15:05:40 -0500
Received: from quechua.inka.de ([193.197.184.2]:57820 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264108AbTKJUFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 15:05:39 -0500
Subject: ide cdrom sg like access / rpcmgr ?
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: small linux home
Message-Id: <1068494681.808.11.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 10 Nov 2003 21:04:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there some documentation on how to access an ide cdrom in 2.6.0*
for converting an app that used ide-scsi and sg devices?
(I'd like to use rpcmgr11.c to unlock my dvd drive. maybe someone
 already ported it to kernel 2.6.*?)

the original source uses:
  fd = open(..., O_RDWR);
write, read and   ioctl(fd, SG_NEXT_CMD_LEN, &cmdlen);
(but the ioctl only on lg drives, mine is a hitachi,
so that shouldn't be necessary).

or will I need ide-scsi to do these things?

Thanks, Andreas

