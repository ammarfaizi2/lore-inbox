Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTBFJiY>; Thu, 6 Feb 2003 04:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTBFJiY>; Thu, 6 Feb 2003 04:38:24 -0500
Received: from f16.mail.ru ([194.67.57.46]:48910 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id <S265857AbTBFJiX>;
	Thu, 6 Feb 2003 04:38:23 -0500
From: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: hdb=flash doesn't help
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 172.29.17.23 via proxy [62.112.80.99]
Date: Thu, 06 Feb 2003 12:48:00 +0300
Reply-To: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E18gidU-000Ams-00@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We have a system with 2 CF-disks connected 
directly to the IDE-controller (PIIX4). We 
used before the "old" IDE-driver hd.c and it 
worked fine, until we had to use a larger 
disk (1.5GB). Then we disabled hd.c, and 
appended hdb=flash. Then initially at boot 
both drives are identified:
PIIX4: IDE controller...
PIIX4 chipset revision 1
PIIX4: not 100% native mode...
    ide0: BM-DMA at...
hda: Hitachi...
hdb: ...
ide0 at...
hdb: 31488 sectors (16MB)...
Partition check:
 hdb: hdb1
...
And that's it. hda never appears again. And 
what is also strange, the order of hda/b is
swapped, compared to the old hd.c driver and
to BIOS settings. What's the reason for this 
behaviour and how do we fix it?

Thanks
Guennadi
---
Guennadi Liakhovetski

