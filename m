Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbTADWY6>; Sat, 4 Jan 2003 17:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbTADWY6>; Sat, 4 Jan 2003 17:24:58 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:64196 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S261624AbTADWYz>;
	Sat, 4 Jan 2003 17:24:55 -0500
Message-ID: <002401c2b441$4e03eff0$18df9641@steven>
From: "Steven Barnhart" <sbarn03@softhome.net>
To: "Andrew Morton" <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-kernel-mm@vger.kernel.org
References: <3E16A2B6.A741AE17@digeo.com> <pan.2003.01.04.15.47.43.915841@softhome.net> <3E174FBB.9065575A@digeo.com>
Subject: Re: 2.5.54-mm3
Date: Sat, 4 Jan 2003 17:31:54 -0500
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


> autofsv4 has been working fine across the 2.5 series.  You'll need to
> send a (much) better report.

I don't really know what the problem is..everything seems to be working
right except when it goes to mount the system from ro mode to rw mode.
Therefore well everything goes down hill after that. I looked through the
/var/log/messages and all those files but nothing specific to the problem.
If I disable fsck and append rw mode kernel boots fine. One minor note, boot
also fails during Mounting other filesystems and gives the typical mount
error about bad superblock, or to many mounted filesystems. My .config was
attached before(?) and that's all I have..anything paticular you are looking
for?

> You could try statically linking it, yes.  More details are needed,
> such as a description of what hardware you have and what driver you're
> using.

I have a i810 Intel graphics card/motherboard, intel celeron 1.06 GHz
processor, and agp 3 enabled, could that be the problem? I have enabled the
intel i810 driver in the graphics area as you can see in the .config. The
intel driver seems to be enabled fine as in the Xfree/GDM log it says
something about Intel. Only error is it can't find device /dev/agpgart even
though it *is* there. Any more info you would need?

