Return-Path: <linux-kernel-owner+w=401wt.eu-S1750973AbXAUAf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbXAUAf0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 19:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbXAUAfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 19:35:25 -0500
Received: from scrye.com ([216.17.180.1]:58195 "EHLO mail.scrye.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbXAUAfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 19:35:24 -0500
X-Greylist: delayed 1689 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jan 2007 19:35:24 EST
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
From: Tony Foiani <tkil@scrye.com>
Reply-To: Tony Foiani <tkil@scrye.com>
X-Attribution: Tony
To: davids@webmaster.com ("David Schwartz")
CC: leon.woestenberg@gmail.com ("Leon Woestenberg"),
       linux-kernel@vger.kernel.org
References: <c384c5ea0701201007t4e637b9eh133101286ce5598d@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEKNBAAC.davids@webmaster.com>
Date: Sat, 20 Jan 2007 17:07:14 -0700
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEKNBAAC.davids@webmaster.com> (David Schwartz's message of "Sat, 20 Jan 2007 14:54:10 -0800")
Message-ID: <gzm8d1bv1.fsf@brand.scrye.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Schwartz <davids@webmaster.com> writes:

David> The way RAM and flash are measured is correct.

In my experience, RAM and flash *drives* are measured differently.  

I understand that individual flash chips come in powers of 2, but by
the time they're packaged as a "flash drive", some of that has been
used up -- yet they're still sold as the full capacity, and the
manufacturers use the confusion between MiB and MB to defend the
practice.

   This "16Mb" drive doesn't really have 16 megabytes of capacity -
   it's really got 15.5. But that's just standard operating procedure
   for storage manufacturers. Non-volatile storage manufacturers,
   including hard drive companies, like to define a megabyte as
   1,000,000 bytes and a gigabyte as 1,000,000,000 bytes. They're
   actually two-to-the-power-of-20 and two-to-the-power-of-30 bytes,
   which is 1,048,576 and 1,073,741,824 bytes respectively. This is
   the main reason why a "20Gb" hard drive won't actually give you
   20Gb of capacity.

   In flash RAM devices, things can get a bit more complex again,
   thanks to the small amount of memory which may be used by the
   device itself for housekeeping. That can vary between device
   families; a CompactFlash card with a given nominal capacity may
   actually have a bit less space than a SmartMedia card with the same
   number on the label. And manufacturers may throw in some more
   memory to push the real capacity up closer to the stated one, which
   is what they've done with the USBDrive. It's still about three per
   cent shy of its claimed capacity, though.

   -- http://www.dansdata.com/flashcomp.htm

(E.g., my "512MB" CF card shows up as "487MB" in the camera -- a
difference of exactly 5%, as would be expected by the MB-vs-MiB scam.
I'd be happier if the camera said "487MiB", but we're looking at OSes
we do have control over, not others.)

And this cheat is getting better (for the seller) with every expansion:

   1 MiB is  5% bigger than 1 MB
   1 GiB is  7% bigger than 1 GB
   1 TiB is 10% bigger than 1 TB

So when you go out to buy your 1TB drive this year, you're really only
buying 0.9TiB or so.

Since all the manufacturers do the same thing, it's possible to
consider it "fair", at least for comparisons -- but when the customer
gets home and formats their drive, I think they'd be happier if the
number was the same as on the carton.

Just last night I formatted some new "500GB" drives, and they
eventually came back with 465GB as the displayed capacity.  Wouldn't
it make more sense to display that as "465GiB"?

David> Talk about a cure worse than the disease! So you're saying that
David> 256MB flash cards could be advertised as having 268.4MB? A
David> 512MB RAM stick is mislabelled and could correctly say 536.8MB? 
David> That's just plain craziness.

No, it sounds like he wants them advertised as 256MB and 512MiB,
respectively -- packaged flash cards tend to use the 1000 multiples,
while DRAM uses the 1024.  One extra letter doesn't sound all that
crazy.

How fast is your Ethernet port?  100Mbps or 95.37Mbps?

Somewhat archaic now, but how big was your common 3.5" floppy disk (PC
"HD" format)?  It actually used a basis of 1,024,000:

   And if two definitions of the megabyte are not enough, a third
   megabyte of 1 024 000 bytes is the megabyte used to format the
   familiar 90 mm (3 1/2 inch), "1.44 MB" diskette.

   -- http://physics.nist.gov/cuu/Units/binary.html

What's likely is that the flash and drive manufacturers will either
mark their products honestly, or they'll increase the capacity of
their product to meet the given label.

(Think about the CRT "diagonal" measurements -- it took a few
lawsuits, but they eventually switched from measuring bezel-to-bezel,
or total tube diagonal, to "viewable".  Sure, everyone in technology
"knew" that you had to chop off an inch or two from the advertised
value to get the viewable; but that's not enough to meet the standard
of truth in advertising.)

David> Adopting IEC 60027-2 just replaces a set of well-understood
David> problems with all new problems.

Which are clearly solved in the standards document, and remove any
ambiguity.  Is one extra character really that painful to you?

t.

