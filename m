Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290294AbSAYG1v>; Fri, 25 Jan 2002 01:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSAYG1k>; Fri, 25 Jan 2002 01:27:40 -0500
Received: from beasley.gator.com ([63.197.87.202]:522 "EHLO beasley.gator.com")
	by vger.kernel.org with ESMTP id <S289881AbSAYG1c>;
	Fri, 25 Jan 2002 01:27:32 -0500
From: "George Bonser" <george@gator.com>
To: "M. Edward Borasky" <znmeb@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux console at boot
Date: Thu, 24 Jan 2002 22:27:28 -0800
Message-ID: <CHEKKPICCNOGICGMDODJOEPGGBAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEPAEGAA.znmeb@aracnet.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> If all else fails, try a scan converter and a VCR with a
> decent freeze-frame
> capability.
>

Well, I imagine if this problem gets released with 2.4.18 there will
probably be someone
that has such a rig already to troubleshoot it :-)

If nobody else runs into it, I will likely hook it up with a serial
console and record the output on a different machine. There were
plenty of SCSI changes in pre7. I backed out the rather harmless
looking change in the aic7xxx driver with no luck so I am guessing it
was something in the generic scsi stuff that broke the ability to find
the disk.

