Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbULUPcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbULUPcl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 10:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbULUPcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 10:32:41 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:20185 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261770AbULUPce convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 10:32:34 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-10.tower-45.messagelabs.com!1103643152!8622536!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ATARAID and KERNEL-2.6.9
Date: Tue, 21 Dec 2004 10:32:30 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC41BF@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ATARAID and KERNEL-2.6.9
Thread-Index: AcTncQmDkcBj5TYUR7OEM3YTwSJ1CgAASVtg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Sasa Ostrouska" <sasa.ostrouska@volja.net>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The boot device is in a RAID-based configuration?

If this is the case, I believe you need to setup an initrd img and setup
LILO accordingly.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sasa Ostrouska
Sent: Tuesday, December 21, 2004 10:19 AM
To: linux-kernel@vger.kernel.org
Subject: ATARAID and KERNEL-2.6.9

Dear Sirs,

        I have a little problem or maybe big one. I try to 
put to work the kernel-2.6.9 on my machine. I have a slackware
current install and the following hardware.

AMD Athlon 
512MB RAM
HPT 370 RAID controller 
and 2 HDD in RAID1

So when I start the kernel-ataraid-2.4.27 everything works OK.
When I start the installed kernel-2.6.9 I get the following error
message:

VFS: Cannot openroot device "7203" or unknown-block(114,3)
Please append a correct "root=" option 
Kernel panic: VFS: Unable to mount root fs on unknown-block(114,3)

On my lilo.conf is root=/dev/ataraid/d0p3 
as this is the / partition. 

I tried to put the root=/dev/hde at the lilo prompt but no 
success. 
I tried many many forums but nobody was able to answer me. So 
my last sollution is you and I will very very apreciate it if 
you can give me some hints how to do it. I append you also a
dmesg from the 2.4.27 kernel. 

Many thanks in advance for your help !!!

Best Regards
Sasa Ostrouska





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
