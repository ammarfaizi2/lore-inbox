Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135970AbRD0DgI>; Thu, 26 Apr 2001 23:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135971AbRD0Df7>; Thu, 26 Apr 2001 23:35:59 -0400
Received: from vill.ha.smisk.nu ([212.75.83.8]:3853 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S135970AbRD0Dft>;
	Thu, 26 Apr 2001 23:35:49 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 6.628467 secs)
Message-ID: <052901c0ceca$e6a543c0$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Alpha compile problem solved by Andrea (pte_alloc)
Date: Fri, 27 Apr 2001 05:34:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello yesterday i installed redhat6.2 on our little alpha server over here.
It's an Ruffian EV56 system, and a hand upgraded redhat to be able to cope
with 2.4.

I got an compile error that told me that pte_alloc was declared wrong in
some files..
Then in the back of my mind i figured that Andrea does a lot of alpha work,
so i grepped after pte_alloc in his patches.

I found:
ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.3/alpha
-numa-2

Now my kernel compiled, and it works great. (Thanks Andrea :))
Just a little gotcha if anyone gets this problem (now it's in the mail
archives, where i didnt find it).

Andrea:
Is that patch harmless, or is it experimental?
Is there any other patches you recommend me to apply to my kernel?


Regards

Magnus Naeslund


