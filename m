Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282148AbRKWN4I>; Fri, 23 Nov 2001 08:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282146AbRKWNz7>; Fri, 23 Nov 2001 08:55:59 -0500
Received: from sis.com.tw ([203.67.208.3]:2924 "EHLO maillog.sis.com.tw")
	by vger.kernel.org with ESMTP id <S282147AbRKWNzp>;
	Fri, 23 Nov 2001 08:55:45 -0500
Message-ID: <047701c17426$19b64740$b5d20ac0@sis.com.tw>
Reply-To: "Nelson Lee" <nelson@sis.com.tw>
From: "Nelson Lee" <nelson@sis.com.tw>
To: "kmliu" <kmliu@sis.com.tw>, <linux-kernel@vger.kernel.org>,
        "Krzysztof Oledzki" <ole@ans.pl>
Cc: "ron" <ronchang@sis.com.tw>, "JasonTsai" <jstsai@sis.com.tw>,
        "charles" <charles@sis.com.tw>, <andre@suse.com>
In-Reply-To: <NDBBJBFIOLNMNHAELGHFKEGACJAA.kmliu@sis.com.tw>
Subject: Re: SiS601?!
Date: Fri, 23 Nov 2001 21:52:33 +0800
Organization: sis-tpa
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-MIMETrack: Itemize by SMTP Server on twtpem01/TPE/SiS(Release 5.0.3 (Intl)|21 March
 2000) at 23/11/2001 09:51:59 PM,
	Serialize by Router on twtpem01/TPE/SiS(Release 5.0.3 (Intl)|21 March 2000) at
 23/11/2001 09:52:05 PM,
	Serialize complete at 23/11/2001 09:52:05 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.M.:

No, we do not have.
]
Best Regards,

Nelson Lee
/\/\/\/\/\/\/\/\/
Sr. Technical Marketing Manager
Integrated Product Division
Silicon Integrated Systems Corp.
6F, NO. 1, ALLEY 1, LANE 235,
BAO CHIAO RD. HSIN TIEN,
TAIPEI, TAIWAN, R.O.C.
TEL:886-2-29161619  ext:381
FAX:886-2-29161618
http://www.sis.com.tw
**************************

----- Original Message -----
From: "kmliu" <kmliu@sis.com.tw>
To: "nelson" <nelson@sis.com.tw>; <linux-kernel@vger.kernel.org>; "Krzysztof
Oledzki" <ole@ans.pl>
Cc: "ron" <ronchang@sis.com.tw>; "JasonTsai" <jstsai@sis.com.tw>; "charles"
<charles@sis.com.tw>; <andre@suse.com>
Sent: Friday, November 23, 2001 8:11 AM
Subject: SiS601?!


> Hi,
>
> We do not have any product which name is SiS601,
>
> The IDE controller is SiS5513, the north bridge is
SiS620/530/630/540/550/635/735/730/740/640/645/640.
>
> Please make sure what is the name of the chipset.
>
> Nelson:
>
> Do we have SiS601 in notebook market?
>
> Regards,
> K.M. Liu
>
> -----Original Message-----
> From: Krzysztof Oledzki [mailto:ole@ans.pl]
> Sent: Friday, November 23, 2001 4:53 AM
> To: linux-kernel@vger.kernel.org
> Cc: kmliu@sis.com.tw; andre@suse.com
> Subject: SIS IDE (sis5513.c)
>
>
> Hello :)
>
> I have a notebook with SIS IDE Chipset - SIS601. This week I have
> installed Linux. It seems that this chipset is not supported by sis5513.c
> driver. I tried adding support myself by putting PCI_DEVICE_ID_SI_601 in
> each switch/case in this file (because I found that it sound work for
> PCI_DEVICE_ID_SI_540 and PCI_DEVICE_ID_SI_620 ). Unfortunetly ugly
> "unknown IDE controller" message still appeard. Then I go to the ide-pci.c
> and noticed that int ide_pci_chipsets here is only one line for SIS:
>
>         {DEVID_SIS5513, "SIS5513",      PCI_SIS5513,    ATA66_SIS5513,
INIT_SIS5513,   NULL,        {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
ON_BOARD,       0 },
>
> and one #define:
> #define DEVID_SIS5513   ((ide_pci_devid_t){PCI_VENDOR_ID_SI,
PCI_DEVICE_ID_SI_5513})
>
> BTW: Am I right, this makes that only PCI_DEVICE_ID_SI_5513 chipset is
> supported and all other chipset listed in sis5513.c will not work?
>
> Ok, I added DEVID_SIS601 (PCI_DEVICE_ID_SI_601) with parameters from
> SIS5513 or all zeros but... now I have "neither IDE port enabled (BIOS)"
> message. So? Is there any way to enable DMA transfers for my HDD? With PIO
> my HDD is verry slow (hdparm shows 3 MB/sek).
>
> Best regards,
>
> Krzysztof Oledzki
>

