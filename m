Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRADGKs>; Thu, 4 Jan 2001 01:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRADGKi>; Thu, 4 Jan 2001 01:10:38 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:7200 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S129348AbRADGKg>; Thu, 4 Jan 2001 01:10:36 -0500
Message-ID: <3A541361.65942CB3@metabyte.com>
Date: Wed, 03 Jan 2001 22:08:33 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: So, what about kwhich on RH6.2?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2001 06:10:34.0307 (UTC) FILETIME=[0C890130:01C07615]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are we going to use Miquel's patch? I cannot build fresh 2.2.x
on plain RH6.2 without it. The 2.2.19-pre6 comes out without it.
Or is "install new bash" the official answer? Alan?

-- Pete

--- linux-2.2.19-pre3/scripts/kwhich	Sun Dec 10 16:49:45 2000
+++ linux-2.2.19-pre3-p3/scripts/kwhich	Sat Dec 23 21:10:33 2000
@@ -7,7 +7,7 @@
         exit 1
 fi
 
-IFS=:
+IFS=":$IFS"
 for cmd in $*
 do
         for path in $PATH
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
