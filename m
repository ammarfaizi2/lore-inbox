Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264230AbRFDM6Y>; Mon, 4 Jun 2001 08:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264243AbRFDM6I>; Mon, 4 Jun 2001 08:58:08 -0400
Received: from roma.axis.se ([193.13.178.2]:46285 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S264230AbRFDM5z>;
	Mon, 4 Jun 2001 08:57:55 -0400
From: johan.adolfsson@axis.com
Message-ID: <005c01c0ecf6$4343ca40$a1b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Oleg Drokin" <green@linuxhacker.ru>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E156VvF-0004D1-00@the-village.bc.nu>
Subject: Re: Linux 2.4.5-ac7
Date: Mon, 4 Jun 2001 14:59:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know the details of the implementation, but the CRIS port
(ETRAX 100LX) has support for USB but no PCI.

/Johan

----- Original Message -----
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Alan Cox <laughing@shared-source.org>; <linux-kernel@vger.kernel.org>
Sent: Sunday, June 03, 2001 1:19 PM
Subject: Re: Linux 2.4.5-ac7


> > AC> 2.4.5-ac7
> > AC> o       Make USB require PCI                            (me)
> > Huh?!
> > How about people from StrongArm sa11x0 port, who have USB host
controller (in
> > sa1111 companion chip) but do not have PCI?
>
> The strongarm doesnt have a USB master but a slave.
>
> > Probably there are more such embedded architectures with USB
controllers,
> > but not PCI bus.
>
> Currently we don't support any of them.
>
> > How about ISA USB host controllers?
>
> They do not exist.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

