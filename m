Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbRBIAUE>; Thu, 8 Feb 2001 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129471AbRBIATy>; Thu, 8 Feb 2001 19:19:54 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:60680 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129465AbRBIATo>; Thu, 8 Feb 2001 19:19:44 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE021@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Adam Schrotenboer'" <ajschrotenboer@lycosmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: Mem detection problem
Date: Thu, 8 Feb 2001 16:19:36 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Adam Schrotenboer [mailto:ajschrotenboer@lycosmail.com]
> 
> This is actually a repost of a problem that received few 
> serious replies (IMNSHO).

Well, I claim not to have ignored it.
I have gone thru the entire patch-2.4.1 file and can't see
anything there that would cause what you are seeing.

You aren't using ACPI, right?  (not in your log files)
[That just makes the patch file of interest smaller.]

> Basically 2.4.0 detects 192 MB(maybe 191, but big whoop) of 
> memory. This 
> is correct. However, 2.4.1-ac6 (as did Linus-blessed 2.4.1) 
> detects 64. 
> The problem is simple. 2.4.1 and later for some reason uses bios-88, 
> instead of e820.
> 
> Attached are the dmesgs from 2.4.0 and 2.4.1-ac6.

Have you booted 2.4.0 again (lately)?  You log file is from
Jan-08-2001.  It may also report only 64 MB now, based on
some kind of BIOS change (or ESCD ...) since Jan-08.

Someone else with a similar "problem" actually had a fruit fly
in one of their slots that caused a problem, so I would ask that
you (a) boot 2.4.0 again to see if it works now and (b) remove
adapters, clean slots, reseat adapters, boot 2.4.1 again.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
