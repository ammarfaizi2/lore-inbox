Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278291AbRJMNvV>; Sat, 13 Oct 2001 09:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278292AbRJMNvL>; Sat, 13 Oct 2001 09:51:11 -0400
Received: from chabotc.xs4all.nl ([213.84.192.197]:46225 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S278291AbRJMNuv>; Sat, 13 Oct 2001 09:50:51 -0400
Subject: Very good results with 2.4.12 on a Dell PowerEdge 2550/PERC 3SI Raid
From: Chris Chabot <chabotc@reviewboard.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 13 Oct 2001 15:51:14 +0200
Message-Id: <1002981074.922.4.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
I just installed linux kernel 2.4.12 on some test PowerEdge 2550 boxes,
with a PERC 3/Si Raid card (4x 10krpm scsi u160 disks, 128Mb cache,  one
raid5 volume, using domsch/adaptecs aacraid driver).

Previously (using 2.4.2 & 2.4.9) the raid volume had a very disapointing
read spead of around 22 Mb/sec (a single disk is faster!). You can
imagine my suprise when i installed 2.4.12, and the read speed went up
to around 60 Mb / Sec ! 

I tested this speed increase with hdparm, bonnie+, and various 'real
life' applications, and it truely is a lot, i repeat _a lot_ faster for
me.

I don't know what changed in the block layer between then and now, but
please don't change it back ! ;-)

	-- Chris Chabot



