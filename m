Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbULFP6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbULFP6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULFP4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:56:38 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:15837 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261548AbULFPyx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:54:53 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-19.tower-45.messagelabs.com!1102348491!8082996!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: nVidea Graphics card not recognised by lspci
Date: Mon, 6 Dec 2004 10:54:41 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC414A@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: nVidea Graphics card not recognised by lspci
Thread-Index: AcTbqidvjo15ut1dSVuj2cu+vU05IQAAbPUg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: <gene.heskett@verizon.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Find your pci.ids file, remove it.

Replace it with this one: 

http://pciids.sourceforge.net/pci.ids

Then, lspci.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Gene Heskett
Sent: Monday, December 06, 2004 10:41 AM
To: linux-kernel@vger.kernel.org
Subject: Re: nVidea Graphics card not recognised by lspci

On Monday 06 December 2004 09:29, Andrew Walrond wrote:

>update-pciids
bash: update-pciids: command not found

System is FC2, kernel 2.6.10-rc3
lspci version 2.1.99-test3

Do I need to grab a newer util package that contains lspci?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
