Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUEWDow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUEWDow (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 23:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUEWDow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 23:44:52 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:14769 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262190AbUEWDou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 23:44:50 -0400
Message-ID: <40B01E31.8060003@blueyonder.co.uk>
Date: Sun, 23 May 2004 04:44:49 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: USB/EHCI boot freeze on 2.6.6-mm5 (and 2.6.6-mm4)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2004 03:44:53.0191 (UTC) FILETIME=[4E95CD70:01C44078]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Javorski wrote:
 > Been running into a wall with this issue on my machine:
 > - Amd AthlonXP-2800
 > - Asus A7N8X-E Deluxe (nForce2 Chipset)
 > - 512MB RAM
 > - single PATA HD


 >  This motherboard supports USB 2.0 and up until 2.6.6-rc3(+patches) I was
 > not running into any problems with it. Now with everything after 2.6.6,
 > my systems locks on boot-up after the following 3 lines:

 > <snip>
 > ...
 > ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
 > ehci_hcd 0000:00:02.2: irq 11, pci mem e0885000
 > ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
 > <snip>
<STUFF DELETED>
Same machine details as above, except I have IDE drives, hub and devices 
are USB 1.1.
I experienced a similar problem while trying to boot up 2.6.6-mm5 (hard 
reset was the only thing that worked). I tried booting 2.6.6-mm4 which 
was the previous kernel I had working, that also gave the same bug,  on 
console=ttyS1, I got reams of messages constantly that mentioned 
usb_storage, I thought mistakenly that I had them captured - will do a 
capture when next convenient. I unplugged the usb card reader and 
2.6.6-mm5 is up and running.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

