Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbRBVPic>; Thu, 22 Feb 2001 10:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130089AbRBVPiW>; Thu, 22 Feb 2001 10:38:22 -0500
Received: from star.atlas-iap.es ([194.224.1.2]:60170 "EHLO star.atlas-iap.es")
	by vger.kernel.org with ESMTP id <S130072AbRBVPiH>;
	Thu, 22 Feb 2001 10:38:07 -0500
From: "Ricardo Galli" <gallir@uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Via UDMA5 3/4/5 is not functional!
Date: Thu, 22 Feb 2001 16:38:48 +0100
Message-ID: <LOEGIBFACGNBNCDJMJMOAEOACEAA.gallir@uib.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then I tried kernel 2.4.1. I issued exactly the same hdparm command.
> i got in syslog the message: "ide0: Speed warnings UDMA 3/4/5 is not
> functional"!


I had the same problem.

Add
append="ide0=ata66 ide1=ata66 ide0=autotune ide1=autotune hda=autotune
hdb=autotune hdc=autotune"
to lilo.conf.


BTW, I am having now CRC errors in IDE1 on the VIA, IDE0 it's ok at udma5
and 30MB/sec.

Regards,

--ricardo
http://m3d.uib.es/~gallir/

