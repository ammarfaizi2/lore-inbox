Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284237AbRLFUq5>; Thu, 6 Dec 2001 15:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284245AbRLFUp0>; Thu, 6 Dec 2001 15:45:26 -0500
Received: from mta22-acc.tin.it ([212.216.176.75]:40701 "EHLO fep22-svc.tin.it")
	by vger.kernel.org with ESMTP id <S285179AbRLFUn5>;
	Thu, 6 Dec 2001 15:43:57 -0500
Message-ID: <3C0FD89A.10B28C7B@iname.com>
Date: Thu, 06 Dec 2001 21:44:10 +0100
From: Luca Montecchiani <m.luca@iname.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: marcelo@conectiva.com.br
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hisax compile fix :

--- drivers/isdn/hisax/config.c.orig    Thu Dec  6 21:34:23 2001
+++ drivers/isdn/hisax/config.c Thu Dec  6 21:34:31 2001
@@ -485,7 +485,7 @@
                if (strlen(str) < HISAX_IDSIZE)
                        strcpy(HiSaxID, str);
                else
-                       printk(KERN_WARNING "HiSax: ID too long!")
+                       printk(KERN_WARNING "HiSax: ID too long!");
        } else
                strcpy(HiSaxID, "HiSax");


ciao,
luca
-- 
----------------------------------------------------------
Luca Montecchiani <m.luca@iname.com>
http://www.geocities.com/montecchiani
SpeakFreely:sflwl -hlwl.fourmilab.ch luca@    ICQ:17655604
-------------------=(Linux since 1995)=-------------------
