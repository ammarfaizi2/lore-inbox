Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbTIKROm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbTIKROm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:14:42 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:40118 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261424AbTIKROi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:14:38 -0400
Date: Thu, 11 Sep 2003 19:13:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches: Descriptions.
Message-ID: <20030911171356.GA5637@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
I have 7 patches for you, all of them affect only s390. The patches are
against linux-bk as of 2003/09/11.

Short descriptions:
1) The usual base bug fix collection for s390.
2) Kconfig update. Arnd added a condition to BLK_DEV_FD in
   drivers/block/Kconfig so that we can use it in the s390 config.
   In addition the s390 block device configs now reside in
   drivers/s390/block/Kconfig where they belong.
3) Guillaume Morin tested xpram on a 64 bit machine and found some bugs.
4) Some bug fixes/improvements for the common i/o layer.
5) dasd format fix. Now unformatted dasd device can be accessed with 2.6.
6) s390 network driver fixes.
7) s390 docu update.

blue skies,
  Martin.

