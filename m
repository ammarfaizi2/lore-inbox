Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKSIMF>; Sun, 19 Nov 2000 03:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKSILy>; Sun, 19 Nov 2000 03:11:54 -0500
Received: from new-smtp1.ihug.com.au ([203.109.250.27]:39947 "EHLO
	new-smtp1.ihug.com.au") by vger.kernel.org with ESMTP
	id <S129136AbQKSILk>; Sun, 19 Nov 2000 03:11:40 -0500
Message-ID: <3A178406.1B0A1C8D@ihug.com.au>
Date: Sun, 19 Nov 2000 18:40:54 +1100
From: Vincent <dtig@ihug.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mount /mnt/cdrom ok!but ls segmentation fault...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Using linux-2.4.0-test11-pre7 right now..., here's what i did,
mount /mnt/cdrom
cd /mnt/cdrom
ls
Segmentation fault
ls
*NOT Responding....*
can't kill /sbin/ls
can't umount /mnt/cdrom
ps , shows ;

613 ?        D      0:00 /bin/ls --color=auto -F -b -T 0
           ^^^^^

i didn't want to reboot...
CDRom door is locked..

BTW, what does D mean in ps?

thanks in advance,

-
Regards, Vincent <dtig@ihug.com.au>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
