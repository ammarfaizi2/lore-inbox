Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUJON1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUJON1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUJON1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:27:10 -0400
Received: from ns2.gabswave.net ([193.219.214.10]:62417 "EHLO gabswave.net")
	by vger.kernel.org with ESMTP id S267447AbUJON1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:27:03 -0400
Message-ID: <002c01c4b2ba$a7d5bbc0$0200060a@STEPHANFCN56VN>
From: "Stephan" <support@bbi.co.bw>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: ERROR: /bin/insmod exited abnormally!
Date: Fri, 15 Oct 2004 15:26:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-gabswave.net-MailScanner-Information: Please contact the ISP for more information
X-gabswave.net-MailScanner: Found to be clean
X-MailScanner-From: support@bbi.co.bw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

System Configuration...
LSI Megaraid 320-1 SCSI Card
Redhat ES 3 , build 3
Boot loader : lilo

I'm running Redhat ES 3 release and after much struggle finally  succeeded 
in compiling the kernel successfully.... I hope :). I'm getting the 
following problems after I've rebooted the system on the newly installed 
kernel.

Now I've done some reading on google about this and the only thing I could 
find was that I should try to change (append="root=LABEL=/") to the actual 
device name where root can be found. I got the same affect.....

Any ideas would be apreciated.

<------------------------------error----------------------------------->
ERROR: /bin/insmod exited abnormally!
Loading sd_mod.ko module
insmod QM_MODULES:

ERROR: /bin/insmod exited abnormally!
Loading megaraid.ko module
insmod QM_MODULES:

ERROR: /bin/insmod exited abnormally!
Loading ext3.ko module
insmod QM_MODULES:

ERROR: /bin/insmod exited abnormally!
Mounting /proc filesystem
Creating block devices
VFS: Cannot open root device or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel Panic: VFS: Unable to mount root fs or unknown -block(0,0) 


