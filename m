Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284538AbRLMSOa>; Thu, 13 Dec 2001 13:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbRLMSOT>; Thu, 13 Dec 2001 13:14:19 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S284540AbRLMSOD>;
	Thu, 13 Dec 2001 13:14:03 -0500
Message-ID: <07cd01c18401$fa397db0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <root@chaos.analogic.com>
Cc: "Thomas Capricelli" <orzel@kde.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1011213125015.444A-100000@chaos.analogic.com>
Subject: Re: Mounting a in-ROM filesystem efficiently
Date: Thu, 13 Dec 2001 13:14:16 -0500
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
Sent: Thursday, December 13, 2001 1:02 PM
Subject: Re: Mounting a in-ROM filesystem efficiently


> Generally, ROM based stuff is compressed before being written to
> NVRAM. It's uncompressed into a RAM-Disk and the RAM-Disk is mounted.
> 
> That way, you can use, say, 2 megabytes of NVRAM to get a 10 to 20
> megabyte root file-system. This also allows /tmp and /var/log to be
> writable, which is a great help because the development environment 
> closely approximates the run-time environment.

That's perfect if you have plenty of RAM to spare.

> FYI, generally NVRAM access is sooooo slow. I don't think you'd
> like to use it directly as a file-system and access-time will be
> a problem unless you modify the kernel. 

Modify the kernel how?

Regards,
Brad

