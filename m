Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272198AbRH3NAp>; Thu, 30 Aug 2001 09:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272199AbRH3NA0>; Thu, 30 Aug 2001 09:00:26 -0400
Received: from f49.pav1.hotmail.com ([64.4.31.49]:64528 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S272198AbRH3NAV>;
	Thu, 30 Aug 2001 09:00:21 -0400
X-Originating-IP: [212.1.135.146]
From: "Sam Halliday" <plendily@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: usbdevfs timeout
Date: Thu, 30 Aug 2001 14:00:34 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F49zyWR4Atg2c7qIA3E000030b1@hotmail.com>
X-OriginalArrivalTime: 30 Aug 2001 13:00:34.0927 (UTC) FILETIME=[C1F637F0:01C13153]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello, im not sure if this is the right place ot be emailing, i use a rio600 
mp3 player attached to my usb. i use the usbdevfs (with program "rioutil" 
from sourceforge) to handle the rio, (not the driver) which works fine, but 
for some small problems which i think may be kernel issues (i have 2.4.9, 
and have tried 2.4.10-pre2 also).....

1- when i attach the rio i get this error (which i ignore because i am not 
using any driver anyway, but it is inconvenient that it pops up every time)
"usb.c: USB device 3 (vend/prod 0x45a/0x5001) is not claimed by any active 
driver"

2- and also when i am uploading songs to my mp3 player, the connection cuts 
out after a minute or so, and i haev to start again (this is VERY 
inconvenient) i get this error when it all locks up:
"usb_control/bulk_msg: timeout"
"usbdevfs: USBDEVFS_BULK failed dev 3 ep 0x82 len 256 ret -110"

i heard the alan cox patches have some bug fix for usbdevfs timeouts, but i 
cant actually get his patches to work... patch keeps saying that the file 
needing patching
doesnt exist, im sure im doing soemthign wrong there though. any help on 
this either? do his patches work differently to the linus tree patches?

please help
Sam, Ireland
--
there are three truths in life: you are born, you will die, and things 
change. ok, maybe one more: everyone has their stella, and when they do, no 
one else can even
compare.... Stephen Dorff, Entropy

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

