Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270828AbUJUUsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270828AbUJUUsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270809AbUJUUru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:47:50 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:20373 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S268778AbUJUUrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:47:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: forcing PS/2 USB emulation off
Date: Thu, 21 Oct 2004 13:47:21 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B3017FC495@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: forcing PS/2 USB emulation off
Thread-Index: AcS3Wg8NSJJ2Hs1CQUurUGCb7aZvYwAVN47A
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Greg KH" <greg@kroah.com>, "Alexandre Oliva" <aoliva@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>,
       "Dmitry Torokhov" <dtor_core@ameritech.net>
X-OriginalArrivalTime: 21 Oct 2004 20:47:22.0020 (UTC) FILETIME=[29B67640:01C4B7AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
>Sent: Thursday, October 21, 2004 2:35 AM
>To: Aleksey Gorelov
>Cc: Greg KH; Alexandre Oliva; Linux Kernel Mailing List; 
>Vojtech Pavlik; Dmitry Torokhov
>Subject: RE: forcing PS/2 USB emulation off
>
>On Iau, 2004-10-21 at 00:22, Aleksey Gorelov wrote:
>> Isn't this interrupt disabled at that point, and status are cleared
>> right
>> after handoff ? Have you actually been able to see a problem 
>with such 
>> an interrupt with this patch applied ?
>
>I've seen one Nvidia case where flipping the USB over caused an
>immediate IRQ on that line.
>

I expect it to be disabled at controller level at the time patch works.
Probably, something enabled it before quirk in Nvidia case...

Aleks.
