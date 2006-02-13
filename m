Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWBMHBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWBMHBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWBMHBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:01:51 -0500
Received: from fmr15.intel.com ([192.55.52.69]:30095 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751080AbWBMHBs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:01:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Linux 2.6.16-rc3
Date: Mon, 13 Feb 2006 01:59:15 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1CF@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.6.16-rc3
Thread-Index: AcYwStHjOtfHPCjdTnC7JdV+LdTOHwAH2W/Q
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Jens Axboe" <axboe@suse.de>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "David S. Miller" <davem@davemloft.net>, "Greg KH" <greg@kroah.com>,
       <linux-acpi@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       "Yu, Luming" <luming.yu@intel.com>,
       "Ben Castricum" <lk@bencastricum.nl>, <sanjoy@mrao.cam.ac.uk>,
       "Helge Hafting" <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       <linux-usb-devel@lists.sourceforge.net>,
       =?iso-8859-1?Q?Gerrit_Bruchh=E4user?= <gbruchhaeuser@gmx.de>,
       <Nicolas.Mailhot@LaPoste.net>, "Jaroslav Kysela" <perex@suse.cz>,
       "Takashi Iwai" <tiwai@suse.de>,
       "Patrizio Bassi" <patrizio.bassi@gmail.com>,
       =?iso-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>,
       "Andrey Borzenkov" <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, "ghrt" <ghrt@dial.kappa.ro>,
       "jinhong hu" <jinhong.hu@gmail.com>,
       "Andrew Vasquez" <andrew.vasquez@qlogic.com>,
       <linux-scsi@vger.kernel.org>, "Benjamin LaHaise" <bcrl@kvack.org>
X-OriginalArrivalTime: 13 Feb 2006 06:59:19.0082 (UTC) FILETIME=[02A7C0A0:01C6306B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>- http://bugzilla.kernel.org/show_bug.cgi?id=6049 - another acpi
>  regression.  We have the actual offending commit here.

per my note in the bug report, I believe that this failure
is not related to the "offending commit", and thus that commit
should not be reverted.  I believe that this failure is because
the system is booted with "pci=noacpi" in IOAPIC mode --
and unsuportable configuration -- and will endeavor to confirm...

thanks,
-Len
