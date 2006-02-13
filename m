Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWBMHnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWBMHnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWBMHnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:43:49 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:46232 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751195AbWBMHns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:43:48 -0500
To: "Brown, Len" <len.brown@intel.com>
cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@suse.de>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "David S. Miller" <davem@davemloft.net>, "Greg KH" <greg@kroah.com>,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>,
       "Ben Castricum" <lk@bencastricum.nl>,
       "Helge Hafting" <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       =?iso-8859-1?Q?Gerrit_Bruchh=E4user?= <gbruchhaeuser@gmx.de>,
       Nicolas.Mailhot@LaPoste.net, "Jaroslav Kysela" <perex@suse.cz>,
       "Takashi Iwai" <tiwai@suse.de>,
       "Patrizio Bassi" <patrizio.bassi@gmail.com>,
       =?iso-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>,
       "Andrey Borzenkov" <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, "ghrt" <ghrt@dial.kappa.ro>,
       "jinhong hu" <jinhong.hu@gmail.com>,
       "Andrew Vasquez" <andrew.vasquez@qlogic.com>,
       linux-scsi@vger.kernel.org, "Benjamin LaHaise" <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3 
In-Reply-To: Your message of "Mon, 13 Feb 2006 02:07:50 EST."
             <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D1@hdsmsx401.amr.corp.intel.com> 
Date: Mon, 13 Feb 2006 07:43:31 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1F8YMt-0002WU-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> systems newer than 6 years old.

According to the sticker on the bottom, this model was made in
04/2000, so the 6 years is right.

> We're talking here about a system from 1999 where Windows 98 refuses
> to run in ACPI mode and instead runs in APM mode.

I haven't tried Windows 98 on this machine, but Windows 98SE would run
in ACPI mode if it weren't for a cheap hack by IBM.  The latest BIOS
(1.11), which I'm using, claims to be from 1999.  However, that date
is almost surely wrong.  The readme/changelog with the BIOS update
diskette is dated Sept 20, 2001 and contains this note about the 1.01
update:

 - (Fix) If Windows 98 Second Edition is installed as APM mode and
         an updated BIOS is installed with a BIOS date 12/02/99 or 
         later, Windows 98SE will change the mode from APM to ACPI 
         whenever a New hardware profile is created.  So this BIOS 
         set the date to 11-30-99. 

Probably IBM marked all the BIOS dates as 11-30-99 in order to work
around this W98SE misfeature.  My guess is that BIOS 1.11 is really
from Sept 2001, or 4.5 years ago.  Old, but not octagenerian!

> I consider that it works in ACPI mode at all as "miraculous":-)

Amen to that.  I was very pleased when the combination of newer ACPI
releases plus my modifying the DSDT made S3 work.

> I do think the issue merits investigation ...

Although I have little idea of what sections of code to modify,
especially since the commit in question merges two well travelled
branches, I'm happy to test patches.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
