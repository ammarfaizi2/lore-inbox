Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUCDVMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 16:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUCDVMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 16:12:17 -0500
Received: from goliath.sylaba.poznan.pl ([213.17.226.43]:7697 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S261787AbUCDVMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 16:12:16 -0500
Subject: 2.6.3 BUG - can't write DVD-RAM - reported as write-protected
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1078434953.1961.13.camel@venus.local.navi.pl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 04 Mar 2004 22:15:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I switched to 2.6.3 from 2.4.x serie.
When I mount DVD-RAM it is mounted read-only:

[root@venus olaf]# mount /dev/dvdram /mnt/dvdram
mount: block device /dev/dvdram is write-protected, mounting read-only
[root@venus olaf]#

In 2.4 it is mounted correctly as read-write.

Drive: Panasonic LF-201, reported in Linux as:
MATSHITA        DVD-RAM LF-D200         A120

SCSI controller: Adaptec 2940U2W

Please CC me.

Regards,

Olaf Fraczyk

