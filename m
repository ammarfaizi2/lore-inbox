Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbTAPVa1>; Thu, 16 Jan 2003 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267282AbTAPVa1>; Thu, 16 Jan 2003 16:30:27 -0500
Received: from fmr01.intel.com ([192.55.52.18]:7113 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267280AbTAPVa0>;
	Thu, 16 Jan 2003 16:30:26 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A847137F76@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Michael Dreher <dreher@math.tu-freiberg.de>, linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: RE: [ACPI] 2.5.58 hangs at boot 
Date: Thu, 16 Jan 2003 13:38:52 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael Dreher [mailto:dreher@math.tu-freiberg.de] 
> 2.5.58 hangs during booting, at this place:
> 
> ......
> BIO: pool of 256 setup, 15Kb (60 bytes/bio)
> biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
> biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
> biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
> biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
> biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
> biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
> ACPI: Subsystem revision 20030109
> 
> 2.5.56 was working OK, except the usual usb problems.

Hi Michael,

Can you stick a printk in ev_sci_handler and see if that's being called
repeatedly?

If not, then could you please narrow down where after the version
printout things are getting hung up?

Thanks -- Regards -- Andy
