Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUC0OFk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 09:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUC0OFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 09:05:40 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:47109 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id S261745AbUC0OFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 09:05:38 -0500
From: Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
To: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee> <20040326185103.GB20819@smtp.west.cox.net>
User-Agent: tin/1.7.4-20040212 ("Taransay") (UNIX) (Linux/2.4.23-170 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Message-Id: <E1B7EHF-0004Jm-DY@ds9.argh.org>
Date: Sat, 27 Mar 2004 14:55:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
> On Fri, Mar 26, 2004 at 08:33:18PM +0200, Meelis Roos wrote:

>> Recent 2.6.5-pre* and -rc1 and -BK don't boot on my Motorola Powerstack
>> (PReP with no RTAS but with OF).
>> 
>> I use netboot to test new kernels.  Normally, the screen is changed to
>> VGA text mode and the bootloader speaks some lines of info and asks for
>> the kernel command line. Now, the image is loaded via tftp (as shown by
>> tcpdump, the last datagram is smaller) and nothing more happens. The
>> cursor stays where it is - at the beginning of the Booting ... line in
>> graphics mode OF environment and that's all.

> Hmm.  Can you hook up a serial line, enable serial console as well and
> see if anything pops out there?

I am seeing the same problem here too (Powerstack II with OF).

Using the serial console does not change to behavior in any way, it is
just stuck after the transmission of the kernel and no further
information is printed.

I even let it stay this way for a long time (read: over 12 hours) and
nothing changed.

The only difference is: Is see this problem since the 2.6.4 (or maybe
even 2.6.3) kernel. I'm a bit short on time right now, so I am
currently not able to specify a correct -BK-release. 

At least I know, 2.6.1 and 2.6.2-rc2 were able to boot, until the
problem with the Tulip/3Com cards hits me
(http://bugzilla.kernel.org/show_bug.cgi?id=1494)

Grüße,
S°

-- 
Fachbegriffe der Informatik - Einfach erklärt
91: Emacs
       Eight Megabytes And Continously Swapping
