Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbSABMET>; Wed, 2 Jan 2002 07:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286966AbSABMEI>; Wed, 2 Jan 2002 07:04:08 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:42890 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id <S286841AbSABMD4>; Wed, 2 Jan 2002 07:03:56 -0500
From: "Raghavendra Koushik" <raghavendra.koushik@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Hot swap support in linux?
Date: Wed, 2 Jan 2002 17:28:50 +0530
Message-ID: <005501c19384$d7fca730$5408720a@M3NOR67026>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-4c2d7344-ff77-11d5-a940-00b0d0d06be8"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <E16LLva-0008AG-00@the-village.bc.nu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-4c2d7344-ff77-11d5-a940-00b0d0d06be8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

few more questions pertaining to hot swap..
1. 	how exactly do I build my linux kernel with hotswap support. When I do
	'make xconfig' (for linux 2.4.4 kernel) I don't see a hotplug option.

2.	If I write my driver according to the new way of writing PCI drivers for
    	ethernet cards i.e using MODULE_DEVICE_TABLE et al, is it enough to
make
	my driver hot pluggable.

3.	Does the NIC need to provide any particular h/w support to make it
	hotpluggable.


Thanks in advance
Koushik


 



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
Sent: Tuesday, January 01, 2002 3:44 PM
To: Raghavendra Koushik
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hot swap support in linux?


> Does the current linux kernel support hot swap feature for
network interface
> cards(NICs). I would be glad if any of you can provide me some pointers or
> documentation regards the same...

If your hardware supports it - yes. You'll need something like the compaq
hotswap pci backplanes or of course simply use cardbus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


------=_NextPartTM-000-4c2d7344-ff77-11d5-a940-00b0d0d06be8
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

------=_NextPartTM-000-4c2d7344-ff77-11d5-a940-00b0d0d06be8--
