Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSBZPJv>; Tue, 26 Feb 2002 10:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSBZPJe>; Tue, 26 Feb 2002 10:09:34 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:9174 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288248AbSBZPJU>; Tue, 26 Feb 2002 10:09:20 -0500
Message-ID: <3C7B78B5.DC539D17@zeroscale.com>
Date: Tue, 26 Feb 2002 12:59:49 +0100
From: Martin Rode <Martin.Rode@zeroscale.com>
Organization: Zeroscale GmbH & Co. KG / Programmfabrik GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reiserfs & Bad Blocks Continued...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I have upgraded my kernel to 2.4.18-pre3-ac1 mounting of a
Reiserfs partition on top of a LVM volume with bad blocks works again.
By bad blocks affected files get a "permission denied" when I try to
read them, this is what I expect.

Now my question: Can I somehow tell reiserfs to work around bad blocks
on my hard drive?

The badblocks util from ext2 finds the bad blocks and according to the
reiserfs homepage there has been a new ioctl for reiserfs to handle bad
blocks. Has this been integrated in the reiserfs version in 2.4.18 ? The
patch for 2.4.8 on the web site does not apply properly. 

My other option would be to use ext3, knowing that ext2 can handle old
and new bad blocks.

What are your sugesstions? Except for: "Go by a new hard drive" ;-) 

With Regards and thank you for your help!

;Martin


-- 
Dipl.-Kfm. Martin Rode
martin.rode@zeroscale.com

Zeroscale GmbH & Co. KG
Frankfurter Allee 73d
10247 Berlin

http://www.zeroscale.com/
http://www.programmfabrik.de/

Fon +49-(0)30-4281-8001
Fax +49-(0)30-4281-8008
Funk +49-(0)163-5321400
