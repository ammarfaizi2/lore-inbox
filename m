Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284768AbRLMSwk>; Thu, 13 Dec 2001 13:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284775AbRLMSwa>; Thu, 13 Dec 2001 13:52:30 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S284768AbRLMSwQ>;
	Thu, 13 Dec 2001 13:52:16 -0500
Message-ID: <080d01c18407$4f741650$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <root@chaos.analogic.com>
Cc: "Thomas Capricelli" <orzel@kde.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1011213132109.707A-100000@chaos.analogic.com>
Subject: Re: Mounting a in-ROM filesystem efficiently
Date: Thu, 13 Dec 2001 13:52:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Thomas Capricelli" <orzel@kde.org>; <linux-kernel@vger.kernel.org>
Sent: Thursday, December 13, 2001 1:34 PM
Subject: Re: Mounting a in-ROM filesystem efficiently


> On Thu, 13 Dec 2001, Bradley D. LaRonde wrote:
> [SNIPPED...]
>
> > Sent: Thursday, December 13, 2001 1:02 PM Subject: Re: Mounting a in-ROM
> > filesystem efficiently
> >
> >
> > > Generally, ROM based stuff is compressed before being written to >
> > NVRAM. It's uncompressed into a RAM-Disk and the RAM-Disk is mounted.  >
> > > That way, you can use, say, 2 megabytes of NVRAM to get a 10 to 20 >
> > megabyte root file-system. This also allows /tmp and /var/log to be >
> > writable, which is a great help because the development environment >
> > closely approximates the run-time environment.
> >
> > That's perfect if you have plenty of RAM to spare.
> >
>
> Well RAM is a hell of a lot cheaper than NVRAM. If you don't have
> the required RAM on your box, the hardware engineers screwed up
> and have to be "educated" preferably with an axe in the parking-lot.

As I mentioned before, there may be other-than-cost considerations for
choosing the amount of RAM on a box.  For example, low power consumption on
portable devices.  For another example, a huge ROM database that doesn't
need to be in RAM all at once.

Regards,
Brad

