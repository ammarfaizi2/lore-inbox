Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287756AbSATKHm>; Sun, 20 Jan 2002 05:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288089AbSATKHd>; Sun, 20 Jan 2002 05:07:33 -0500
Received: from david.siemens.de ([192.35.17.14]:65154 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S287756AbSATKHU>;
	Sun, 20 Jan 2002 05:07:20 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Query removable drives (CD-ROMs, flopies etc) for media presence
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.11mdk 
Date: 20 Jan 2002 13:07:12 +0300
Message-Id: <1011521234.2526.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there reliable way to query drives for media presence? I have tried
query_disk_change but it returns 1 if called without media inserted (it
correctly works if media is present when it is called). I need it for
CD-ROMs (IDE or SCSI) and possibly for other drives with removable media
like floppy, Zip, Jaz.

So far I tried with two IDE CD-ROMs and floppy and all show the same -
query_disk_change always 1 when no media is present.

The reason is I'd like to avoid media access when it is known no media
is present. The kernel is 2.4.17.

TIA

-andrej


