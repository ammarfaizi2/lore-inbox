Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbRDDTTR>; Wed, 4 Apr 2001 15:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRDDTTH>; Wed, 4 Apr 2001 15:19:07 -0400
Received: from denise.shiny.it ([194.20.232.1]:11539 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S131953AbRDDTTC>;
	Wed, 4 Apr 2001 15:19:02 -0400
Message-ID: <3ACA41F9.FCC07369@denise.shiny.it>
Date: Tue, 03 Apr 2001 23:34:49 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: new aic7xxx driver problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have two Adaptec 2930CU (ultra narrow) cards. I modified the driver to
make them work in ultra mode. The card connected to my CDROM and MO drive,
operating at different bus clocks, does not behave well. Transfers stop
often for 10-20 seconds and it spits out warnings like these:

Apr  3 23:05:10 Jay kernel: scsi1:0:4:0: Attempting to queue an ABORT message 
Apr  3 23:05:10 Jay kernel: scsi1:0:4:0: Command found on device queue 
Apr  3 23:05:10 Jay kernel: aic7xxx_abort returns 8194 
Apr  3 23:05:10 Jay kernel: scsi1:0:5:0: Attempting to queue an ABORT message 
Apr  3 23:05:10 Jay kernel: scsi1:0:5:0: Command found on device queue 
Apr  3 23:05:10 Jay kernel: aic7xxx_abort returns 8194 
Apr  3 23:06:23 Jay kernel: scsi1:0:4:0: Attempting to queue an ABORT message 
Apr  3 23:06:23 Jay kernel: scsi1:0:4:0: Command found on device queue 
Apr  3 23:06:23 Jay kernel: aic7xxx_abort returns 8194

No probs with the old driver.

[Linux 2.4.3, aic7xxx v6.1.8, gcc 2.95.3, PowecPC 750]

Bye.


