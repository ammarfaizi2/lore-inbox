Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRADVaq>; Thu, 4 Jan 2001 16:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRADVah>; Thu, 4 Jan 2001 16:30:37 -0500
Received: from [63.109.146.2] ([63.109.146.2]:20212 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S129370AbRADVaS>;
	Thu, 4 Jan 2001 16:30:18 -0500
Message-ID: <4461B4112BDB2A4FB5635DE1995874320223BC@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Igmar Palsenberg'" <maillist@chello.nl>
Cc: Sven Koch <haegar@cut.de>,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: RE: 2.2.18 and Maxtor 96147H6 (61 GB)
Date: Thu, 4 Jan 2001 13:30:04 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had exactly this problem with the Maxtor 61 GB drive on my 
Pentium based server.  Theoretically a BIOS upgrade could fix it,
but ASUS quit making BIOS upgrades for my motherboard two years
ago.

I solved the problem by getting a Promise Ultra 100 controller
and putting the drive on that. Works perfectly under Linux 
Mandrake 2.2.17-mdk-21 - it shows up as /dev/hde.  They are
cheap controllers if you don't get the RAID version.

Best wishes.

Torrey Hoffman


> From: Igmar Palsenberg [mailto:maillist@chello.nl]
> Sent: Thursday, January 04, 2001 1:43 PM
> Yeah.. I removed the clipping, and the machine won't boot. It halts after
> PnP init. Any way to use full capacity with the clipping enabled ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
