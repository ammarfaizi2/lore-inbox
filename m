Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbUE2Trj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUE2Trj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUE2Trj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 15:47:39 -0400
Received: from imap.gmx.net ([213.165.64.20]:53671 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263937AbUE2Trf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 15:47:35 -0400
X-Authenticated: #4512188
Message-ID: <40B8E8D4.1010905@gmx.de>
Date: Sat, 29 May 2004 21:47:32 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc1-mm1: libata flooding my log
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed following messages appearing very often in my log:

FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
0x00 0x20 0x00
FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
0x00 0x20 0x00
FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
0x00 0x20 0x00
FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
0x00 0x20 0x00
FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
0x00 0x20 0x00
FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
0x00 0x20 0x00


Any idea of what is going on? Is dmesg output needed? The system seesm 
to behave rel normal, beside a bit performance degration, I think.

BTW, the new libata version does two good things:
- write back is activated
- now hdparm -t /dev/sda gives high throughoutput straight form the 
first time.

Cheers,

Prakash
