Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136149AbRECHd2>; Thu, 3 May 2001 03:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136161AbRECHbl>; Thu, 3 May 2001 03:31:41 -0400
Received: from tpau.muc.eurocyber.net ([195.143.108.12]:42250 "EHLO
	tpau.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S136149AbRECHbP>; Thu, 3 May 2001 03:31:15 -0400
Message-ID: <3AF10956.7580E25F@TeraPort.de>
Date: Thu, 03 May 2001 09:31:34 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pcmcia problems after upgrading from 2.4.3-ac7 to 2.4.4
Content-Type: multipart/mixed;
 boundary="------------4E4847E4D074EF9B64F11C3A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4E4847E4D074EF9B64F11C3A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

 my DE-620 pccard stopped working after upgrading the kernel from
2.4.3-ac7 to 2.4.4. This is on a Toshiba 4080XCDT. I used the "good"
.config from the 2.4.3-ac7 build to do a make "oldconfig". The symptoms
at startup are:

>PCMCIA: Starting services:
>PCMCIA: using scheme: SuSE
>/lib/modules/2.4.4/kernel/drivers/pcmcia/i82365.o: init_module: No such device
>Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ >parameters
>/lib/modules/2.4.4/kernel/drivers/pcmcia/i82365.o: insmod >/lib/modules/2.4.4/kernel/drivers/pcmcia/i82365.o failed
>/lib/modules/2.4.4/kernel/drivers/pcmcia/i82365.o: insmod i82365 failed
>/lib/modules/2.4.4/kernel/drivers/pcmcia/ds.o: init_module: Operation not permitted
>/lib/modules/2.4.4/kernel/drivers/pcmcia/ds.o: insmod >/lib/modules/2.4.4/kernel/drivers/pcmcia/ds.o failed
>/lib/modules/2.4.4/kernel/drivers/pcmcia/ds.o: insmod ds failed
>cardmgr[189]: starting, version is 3.1.22
>PCMCIA: cardmanager is running
>cardmgr[189]: no pcmcia driver in /proc/devices
>cardmgr[189]: exiting

 As I said, worked fine until/including 2.4.3-ac7. Any ideas? And before
I forget, the base System is SuSe7.1 and all the packages mentioned in
Documentation/Changes are at the required (or better) levels.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------4E4847E4D074EF9B64F11C3A
Content-Type: text/x-vcard; charset=us-ascii;
 name="Martin.Knoblauch.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Martin.Knoblauch
Content-Disposition: attachment;
 filename="Martin.Knoblauch.vcf"

begin:vcard 
n:Knoblauch;Martin
tel;cell:+49-170-4904759
tel;fax:+49-89-510857-111
tel;work:+49-89-510857-309
x-mozilla-html:FALSE
url:http://www.teraport.de
org:TeraPort GmbH;IT-Services
adr:;;Garmischer Straße 4;München;Bayern;D-80339;Germany
version:2.1
email;internet:Martin.Knoblauch@TeraPort.de
title:Senior System Engineer
x-mozilla-cpt:;32160
fn:Martin Knoblauch
end:vcard

--------------4E4847E4D074EF9B64F11C3A--

