Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRB1O6k>; Wed, 28 Feb 2001 09:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130206AbRB1O6a>; Wed, 28 Feb 2001 09:58:30 -0500
Received: from pop.gmx.net ([194.221.183.20]:62587 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S130202AbRB1O60>;
	Wed, 28 Feb 2001 09:58:26 -0500
Message-ID: <3A9D1202.9A1C403E@gmx.de>
Date: Wed, 28 Feb 2001 15:58:11 +0100
From: Martin Rauh <martin.rauh@gmx.de>
X-Mailer: Mozilla 4.6 [de] (WinNT; U)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Writing on raw device with software RAID 0 is slow
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Writing to an software RAID 0 containing 4 SCSI discs is very fast.
I get transfer rates of about 100 MBytes/s. The filesystem on the RAID
is ext2.

Writing to the same RAID directly (that means on the raw device without
a filesystem) works
but gives low transfer rates of about 31 MBytes/s.

Any explanation for that?

thanks and greetings,

Martin Rauh



