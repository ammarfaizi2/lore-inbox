Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278714AbRKOA0A>; Wed, 14 Nov 2001 19:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278742AbRKOAZu>; Wed, 14 Nov 2001 19:25:50 -0500
Received: from mail126.mail.bellsouth.net ([205.152.58.86]:47066 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278714AbRKOAZl>; Wed, 14 Nov 2001 19:25:41 -0500
Message-ID: <3BF30B6D.F42FEAB2@mandrakesoft.com>
Date: Wed, 14 Nov 2001 19:25:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Stuart MacDonald <stuartm@connecttech.com>, tytso@mit.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Fw: [Patch] Some updates to serial-5.05
In-Reply-To: <00df01c16d23$b409ab20$294b82ce@connecttech.com> <20011115001016.C19575@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> I don't actually printk() the serial ports that have been discovered at
> boot time in the new serial CVS.  If people scream enough, I could be
> persuaded.  I'm currently of the opinion that they're noise, and if
> we're really interested in them, we've got a userspace tool to do it
> for us: setserial -bg /dev/ttyS*

I'll complain ;-)   It seems pretty standard for a driver to print out
at least one single line for each "interface" it registers; interface in
this case being ttySn.  IDE and SCSI layers print out hdX, ethernet
drivers print out ethX; serial should printk ttySx.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

