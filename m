Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131410AbQLZUBk>; Tue, 26 Dec 2000 15:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131969AbQLZUBV>; Tue, 26 Dec 2000 15:01:21 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:6417 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S131410AbQLZUBJ>; Tue, 26 Dec 2000 15:01:09 -0500
Date: Tue, 26 Dec 2000 14:30:28 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: linux-kernel@vger.kernel.org
Cc: mhw@wittsend.com
Subject: Any idea about this - SCSI Scanner...
Message-ID: <20001226143028.A15966@alcove.wittsend.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, mhw@wittsend.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all!

	I'm just now getting around to trying to get my SCSI based scanner
(Mustek MFS-6000CX) working with Sane and ran into a problem.  The Linux
kernel doesn't seem to be recognizing it at all.  The Adaptec BIOS
shows it on the bus prior to bootup (target 2 on the SCSI bus) but
when the kernel comes up it sees all the drives and the CD-RW drive and
the ZIP drive, but doesn't seem to see ANYTHING on target two (consequently
the SCSI generic device is not seeing the Scanner).  The Scan app
"find-scanner" also reports no scanner on the SCSI bus.

	Anyone know why the Adaptec board and BIOS would see the scanner
but the Linux kernel would not?

	For reference...  I'm running 2.4.0test12.  I'm about to set up
to retest against 2.2.18 as well.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
