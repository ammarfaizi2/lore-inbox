Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTECVPE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTECVPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:15:04 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:58772 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263424AbTECVPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:15:03 -0400
Date: Sat, 3 May 2003 17:24:40 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Reserving an ATA interface
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305031727_MC3-1-373D-FBDF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So every time you remove your disks from one of your PCI IDE controllers,
> your ide-cs will get diffirent hwif and drives mappings and your RAID
> on ide-cs won't be recognized ;-)

  I don't know what happens with hotplug, but md with persistent
superblocks and autorun (partition type 0xfd) has stable names.
It only whines a bit when the underlying device names change...


