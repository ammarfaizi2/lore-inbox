Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132593AbRA0PrU>; Sat, 27 Jan 2001 10:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133029AbRA0PrK>; Sat, 27 Jan 2001 10:47:10 -0500
Received: from [207.174.228.187] ([207.174.228.187]:5893 "EHLO www2.xprs.net")
	by vger.kernel.org with ESMTP id <S132593AbRA0Pqy>;
	Sat, 27 Jan 2001 10:46:54 -0500
From: "Todd Goodman" <tsg@bonedaddy.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Hang when booting 2.4.0
Date: Sat, 27 Jan 2001 10:45:06 -0500
Message-ID: <GJEOKKBKGLJFIALOCJCKGECPEFAA.tsg@bonedaddy.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010126194101.B1171@jack.bonedaddy.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I was experiencing a senior moment and had the wrong CPU type
configured.

Once corrected everything is right in the world again.

Thanks to Mark Hahn for pointing out my mistake.

Todd

> -----Original Message-----
> My apologies in advance if I missed this in the archives (I found three
> or four threads discussing hangs at boot, but none related to 2.4.0 and
> the suggestions for older kernels that still applied to code in 2.4.0
> didn't change the symptoms).
> 
> My kernel hangs after the "Ok, booting the kernel." message.
> 
> This is on a machine with a DX440LX motherboard and only a single
> 300Mhz PII installed.
> 
> I can boot 2.2.16 and 2.2.18 kernels successfully.
> 
> I've tried paring down the config to a minimum (.config included below),
> but still have the problem.  Specifically removing any SCSI since I
> had heard of problems with the AIC-78xx.
> 
> Thanks for any ideas or insight,
> 
> Todd Goodman

[SNIP of .config]

> Please read the FAQ at http://www.tux.org/lkml/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
