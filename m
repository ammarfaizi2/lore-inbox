Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270652AbRHNV2n>; Tue, 14 Aug 2001 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270672AbRHNV2d>; Tue, 14 Aug 2001 17:28:33 -0400
Received: from MailAndNews.com ([199.29.68.123]:60936 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S270652AbRHNV2Q>;
	Tue, 14 Aug 2001 17:28:16 -0400
X-WM-Posted-At: MailAndNews.com; Tue, 14 Aug 01 17:28:11 -0400
Message-ID: <002201c12507$c0d26fe0$c405a33e@brekoo.noip.com>
From: "Marc Brekoo" <m_brekoo@mailandnews.com>
To: "Alex Hill" <alexh@legato.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <03d601c124d5$6cb01e80$c405a33e@brekoo.noip.com> <997820924.3545.14.camel@steam.legato.com>
Subject: Re: ACPI & Promise Ultra 100 IDE-controller?
Date: Tue, 14 Aug 2001 23:26:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alex Hill said:

> I have also had problems w/ the same sort of configuration. I am using a
> K6-III on an older Via 100 mb and the Promise Ultra 100 controller is an
> add on card. I found that the the pdc202xx driver has some problems with
> quantum drives, I have always had to patch the driver, adding my quantum
> 13.6gb drive's OEM string to the list of quirky drives
> (pdc_quirk_drives[]:line223 of /usr/src/linux-2.4/drivers/ide/pdc202xx.c
> ) . There are already a couple of quantum drives on this list. I can't
> figure out if it is the VIA motherboard, the promise card or the quantum
> hd, or a combination of the three that causes the problem.

What a coincidence... I have a Quantum Bigfoot drive hooked up to the
controller.
But what I meaned to ask: did your kernel boot when you added the OEM-string
to
pcd_quirk_drives[]?

I'll give it a try as soon as possible, to see if it works here.

Thanks,
Marc.


