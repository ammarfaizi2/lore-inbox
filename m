Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbREMX6C>; Sun, 13 May 2001 19:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbREMX5w>; Sun, 13 May 2001 19:57:52 -0400
Received: from hera.cwi.nl ([192.16.191.8]:37784 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262016AbREMX5h>;
	Sun, 13 May 2001 19:57:37 -0400
Date: Mon, 14 May 2001 01:57:33 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105132357.BAA40155.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4
Cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If I am not mistaken, Richard Hirst has also done work on this thing.

> He did 53c710+. The 700 and 700/66 are much less capable devices.

Yes. But long ago he wrote:
---
You need quite a different driver from the 53c710 drivers that
exist, because 53c700 doesn't have DSA register.  I've attached
a diff for 2.4.0-test9 which adds sim700.{c,h,scr}.  That driver
is supposed to handle 53c700 and 53c710 and be a replacement for
sim710.c.
---

> the NCR 53c700/66 is mapped at 0xCC0-0xCFF.

Good! You are well-organized. I also had that someplace.

> system board id ... mac address

I am not quite sure what you mean by System Board Id.
The EISA ID of this thing is INT3061.

Andries

