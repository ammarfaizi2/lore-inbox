Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129791AbRBITqe>; Fri, 9 Feb 2001 14:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbRBITqX>; Fri, 9 Feb 2001 14:46:23 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:64260 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129791AbRBITqH>; Fri, 9 Feb 2001 14:46:07 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE683@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Dale P. Smith'" <dpsm@en.com>, acpi@phobos.fachschaften.tu-muenchen.de
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ACPI driver overhaul (was: Thermal monitor)
Date: Fri, 9 Feb 2001 11:44:39 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dale,

Thanks! Applied.

I feel I must mention that while I (and you, and others) have been working
on improving the current codebase, other people here have been working on a
totally different design. In general, the new codebase has better ACPI
functionality, is more modular, etc. My hope is that we can switch over to
the new stuff soon (a month?)

What this will mean is that:
1) We will get a lot of new functionality, all at once.
2) Some of that new functionality will be broken.
3) We will lose some of the old functionality, short-term.

At least initially, the /proc interface for the new code will look like the
current code, until it stabilizes, so the new code will have /proc code
drawn heavily from the current implementation.

Also, I don't think this is the last big architecture change ACPI and Linux
will go through. But, this new design will help us prototype the next
change, whereas the current model cannot.

Regards -- Andy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
