Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135661AbRARPCJ>; Thu, 18 Jan 2001 10:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135802AbRARPB7>; Thu, 18 Jan 2001 10:01:59 -0500
Received: from [202.123.212.187] ([202.123.212.187]:6917 "EHLO ns1.b2s.com")
	by vger.kernel.org with ESMTP id <S135801AbRARPBp>;
	Thu, 18 Jan 2001 10:01:45 -0500
Message-ID: <3A67056F.ECB60B8@vtc.edu.hk>
Date: Thu, 18 Jan 2001 23:02:08 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel list <linux-kernel@vger.kernel.org>
Subject: rsync + ssh fail on raid; okay on 2.2.x
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear folks,

I use rsync to transfer my mail (including this list) from work to home
over ppp ussing OpenSSH 2.3.0.  I have no problem transfering  hundreds
of megabytes of my babies' photos from a non-raid partition (going to
work), but I get:

nsmail/Inbox
Write failed: Cannot allocate memory
unexpected EOF in read_timeout

about 19 times out of 20 (1 success so far)
Kernel: 2.4.0, no patches
PIII 450MHz, 256MB RAM, Acus P3B-F motherboard (Intel 440BX)
Mail going to Raid 1 device
The file Inbox is only 2.9MB
OS = Red Hat 7 with all updates, both home and work.
Same with ppp 2.3.x and ppp 2.4.0
Same whether work machine runs 2.2.16 or 2.4.0 kernel.

Any suggestions on where to begin to look for the problem?  I really
need my email.

--
Nick Urbanik, Dept. of Computing and Mathematics
Hong Kong Institute of Vocational Education (Tsing Yi)
email: nicku@vtc.edu.hk
Tel:   (852) 2436 8576, (852) 2436 8579   Fax: (852) 2435 1406
pgp ID: 7529555D fingerprint: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
