Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289577AbSBEPP6>; Tue, 5 Feb 2002 10:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289583AbSBEPPr>; Tue, 5 Feb 2002 10:15:47 -0500
Received: from mailgate.bridgetrading.com ([62.49.201.178]:48290 "EHLO 
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S289577AbSBEPP2>; Tue, 5 Feb 2002 10:15:28 -0500
From: "Chris Funderburg" <ChrisFunderburg@directcommunications.net>
To: "'Drew P. Vogel'" <dvogel@intercarve.net>,
        "'Roy Sigurd Karlsbakk'" <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: opening a bzImage?
Date: Tue, 5 Feb 2002 15:15:21 -0000
Message-ID: <008f01c1ae57$edbe3d20$2802360a@bti.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0090_01C1AE57.EDBE3D20"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <Pine.LNX.4.33.0202050950030.20253-100000@northface.intercarve.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0090_01C1AE57.EDBE3D20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


A bzImage isn't bzipped.  It doesn't have anything to do with the "bzip"
program.

[root@aries boot]# file bzImage 
bzImage: x86 boot sector


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Drew P. Vogel
Sent: 05 February 2002 14:55
To: Roy Sigurd Karlsbakk
Cc: linux-kernel@vger.kernel.org
Subject: Re: opening a bzImage?


The GPL does not require them to give you the .config.

I've never tried this, but could you do something like

bunzip2 -c bzImage > zImage && ar -t zImage

?

--Drew Vogel

On Tue, 5 Feb 2002, Roy Sigurd Karlsbakk wrote:

>hi
>
>I have this bzImage file given to me from a company. They don't want to

>give me the .config, but I need it, so I thought I'd try to
>
> - open the bzImage to a vmlinux
> - list the .o's in the vmlinux
>
>Is this possible?
>
>Btw.. Does GPL require them to give me the .config file?
>
>roy
>
>--
>Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
>
>Computers are like air conditioners.
>They stop working when you open Windows.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"

>in the body of a message to majordomo@vger.kernel.org More majordomo 
>info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_0090_01C1AE57.EDBE3D20
Content-Type: text/x-vcard;
	name="Chris Funderburg.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Chris Funderburg.vcf"

BEGIN:VCARD
VERSION:2.1
N:Funderburg;Chris
FN:Chris Funderburg
ORG:DCI (Europe);IT
TITLE:Senior Systems Administrator
TEL;WORK;VOICE:+44 (020) 8400 6438
TEL;CELL;VOICE:+44 07939409842
TEL;WORK;FAX:+44 (020) 8400 2012
ADR;WORK;ENCODING=3DQUOTED-PRINTABLE:;Old Isleworth;Europa =
House=3D0D=3D0AChurch Street;Old Isleworth;Middlesex;TW7 6=3D
DA;United Kingdom
LABEL;WORK;ENCODING=3DQUOTED-PRINTABLE:Old Isleworth=3D0D=3D0AEuropa =
House=3D0D=3D0AChurch Street=3D0D=3D0AOld Isleworth, Middl=3D
esex TW7 6DA=3D0D=3D0AUnited Kingdom
ADR;HOME:;;;Newbury;Berkshire;RG14 2PL;United Kingdom
LABEL;HOME;ENCODING=3DQUOTED-PRINTABLE:Newbury, Berkshire RG14 =
2PL=3D0D=3D0AUnited Kingdom
URL;HOME:http://Chris.Funderburg.com
URL;WORK:http://Chris.Funderburg.com
ROLE:System Administrator / Developer
EMAIL;PREF;INTERNET:ChrisFunderburg@directcommunications.net
EMAIL;INTERNET:ChrisFunderburg@directcommunications.net
REV:20011026T112741Z
END:VCARD

------=_NextPart_000_0090_01C1AE57.EDBE3D20--

