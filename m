Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVAROYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVAROYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVAROYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:24:18 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:54937 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261307AbVAROYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:24:06 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-20.tower-45.messagelabs.com!1106058245!9532863!1
X-StarScan-Version: 5.4.5; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.4: "access beyond end of device" after ext2 mount
Date: Tue, 18 Jan 2005 09:24:03 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC42B3@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4: "access beyond end of device" after ext2 mount
thread-index: AcT9aEm0rV89UYGzSimjKZBC7dXyGQAALmWw
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Mario Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the problem with the drive on the promise board or the drive on the
VIA chipset?

(from google)
Soyo SY-7VBA133U VIA 694T SY-7VBA133U : ComputerHQ.com3
... Main Specifications. Product Description, SOYO Socket 370
SY-7VBA133U - mainboard -
ATX - Pro133T. ... Audio Output, Sound card - VIA VT82C686B - 16-bit -
stereo. ...

I have the -EXACT- same chipset on an older Soyo Motherboard and have
the same problem you are having, the motherboard did not support drives
over 32GB or it was because I had the 32GB clip (pins on the back of the
hard drive) shorted.  Did you check your HDD manual to see if you have
the 32GB clip enabled?  If so, you need to disable this.

Justin.


-----Original Message-----
From: Mario Holbe [mailto:Mario.Holbe@TU-Ilmenau.DE] 
Sent: Tuesday, January 18, 2005 9:15 AM
To: Piszcz, Justin Michael
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount

On Tue, Jan 18, 2005 at 09:05:05AM -0500, Piszcz, Justin Michael wrote:
> Okay but what hard drive model and IDE Chipset/Controller are you
using?

VIA vt82c686b onboard
PDC20269 (Promise U133TX2) on PCI

hda: WDC WD400EB-00CPF0, ATA DISK drive
hdc: IC35L080AVVA07-0, ATA DISK drive
hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
hdg: SAMSUNG SP1614N, ATA DISK drive

hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
UDMA(100)
hdc: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63,
UDMA(100)
hdg: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63,
UDMA(100)

However, it doesn't matter :)


Mario
-- 
<delta> talk softly and carry a keen sword
