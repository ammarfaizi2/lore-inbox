Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130049AbQKAAQ7>; Tue, 31 Oct 2000 19:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130765AbQKAAQt>; Tue, 31 Oct 2000 19:16:49 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:53262 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130049AbQKAAQp>; Tue, 31 Oct 2000 19:16:45 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBDF@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Benson Chow'" <blc@q.dyndns.org>, linux-kernel@vger.kernel.org
Cc: "'Gerald.Haese@gmx.de'" <Gerald.Haese@gmx.de>
Subject: RE: USB Printer, in 2.4.0-test9
Date: Tue, 31 Oct 2000 16:16:23 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can you try the USB printer driver in 2.4.0-test10 and
let me know if it works for you?  [It works for me.]

~Randy_________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

> Strange things here.
> 
> I'm testing out 2.4.0-test9 kernel with USB, (reiserfs built in, but,
> hopefully this has nothing to do with it).
> 
> Hardware is a 440FX Dual PPro200/Natoma + 82371SB PIIX3/USB.
> Printer: HP DeskJet 880C USB/Parallel
> Mouse: Microsoft Intellimouse with Intellieye USB
> Other stuff: Belkin "Macintosh" USB hub
> 
> Symptoms:
> 
> USB Mouse appears to work totally fine.
> 
> USB Printer will print a few bytes, and suddenly print garbage
> (bitmap/pcl). I tried printing out some plain text and it's 
> MANGLING bits
> - corrupting random bytes of data.  The general structure of bytes are
> still there, but the resultant printout is gibberish.  
> (source print file
> is a text file printed via "cat file >/dev/usblp0" (which is device
> 180,0))
> 
> I get a bunch of form feeds too but it continues to print a 
> few characters
> fine and some that are totally wrong.  It looks like it's 
> corrupting about
> 5% of the characters, including some high bit 7 characters.
> 
> Any ideas what's going on, and is this repeatable by anyone else?  Bad
> hardware?  This SMP box only supports one form of the MPS, and I'm not
> sure how to tell the difference... I also tried using the 
> printer w/o the hub, and same results...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
