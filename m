Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBMRar>; Tue, 13 Feb 2001 12:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBMRa2>; Tue, 13 Feb 2001 12:30:28 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:6918 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S129027AbRBMRaS>; Tue, 13 Feb 2001 12:30:18 -0500
Message-ID: <8C91B010B3B7994C88A266E1A72184D3116FD6@cceexc19.americas.cpqcorp.net>
From: "Zink, Dan" <Dan.Zink@COMPAQ.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.mandrakesoft.com>,
        Tim Wright <timw@splhi.com>
Cc: Adam Lackorzynski <al10@inf.tu-dresden.de>,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: RE: PCI bridge handling 2.4.0-test10 -> 2.4.2-pre3
Date: Tue, 13 Feb 2001 11:30:20 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it make sense to try and keep up with the latest and greatest in
chipsets
when there is a hardware independent way of doing things?  You may be able
to
get information on current chipsets, but every time something changes, the
kernel may be broken for a time.  If we rely on the BIOS, the kernel can
stay
out of the chipset information race.  I understand the reluctance to depend
on BIOS in general but isn't it safe to say that systems using the
ServerWorks
chipsets in question are likely servers with a non-broken BIOS?

I can tell you that if the BIOS doesn't report this stuff right on a
ProLiant
server, it would never make it out the door.  It would break too many things
to go unnoticed.  From this standpoint, the kernel is less likely to break
if
it relies on the BIOS rather than assuming some particular chipset design
that can easily change in the future.  This is a fundamental reason for the
BIOS's existence.

Dan

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@mandrakesoft.mandrakesoft.com]
Sent: Tuesday, February 13, 2001 11:12 AM
To: Tim Wright
Cc: Adam Lackorzynski; Jan-Benedict Glaw; linux-kernel@vger.kernel.org;
Zink, Dan
Subject: Re: PCI bridge handling 2.4.0-test10 -> 2.4.2-pre3


On Tue, 13 Feb 2001, Tim Wright wrote:
> I believe that, in general, we want working fixup routines so the we don't
> have to rely on the BIOS. That said, it's apparent that the ServerWorks
> routines are broken. Fixing them is going to be troublesome, given
ServerWorks
> attitude towards releasing specs. It's on my list of things to try to sort
out,
> since some of the Netfinities I use are ServerWorks based.

We can get tech info on ServerWorks...  just ask specific questions, and
hardware contacts etc. will do the rest.

	Jeff


