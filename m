Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRDSOy1>; Thu, 19 Apr 2001 10:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbRDSOyR>; Thu, 19 Apr 2001 10:54:17 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:47112 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129381AbRDSOyL>;
	Thu, 19 Apr 2001 10:54:11 -0400
Date: Thu, 19 Apr 2001 16:54:06 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: via udma100 fix
To: andre@linux-ide.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3ADEFC0E.F64A4EF8@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick (andre@linux-ide.org) wrote :

> Hi Dan, 
> 
> This was sent to me the other day, is this waht you are talking about? 
> 
> Cheers, 

+       /*
+        *    Turn off PCI Latency timeout (set to 0 clocks)
+        */
+       pci_write_config_byte(dev, 0x75, 0x80);

Is turning off PCI Latency a good thing ?

Anyway the article (http://home.tiscalinet.de/au-ja/review-kt133a-4.html)
says that any value below 32 is good, so why not use 16 for example ?

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
