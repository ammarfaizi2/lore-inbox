Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292597AbSBUAT0>; Wed, 20 Feb 2002 19:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292598AbSBUATR>; Wed, 20 Feb 2002 19:19:17 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:19679 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S292597AbSBUATD>; Wed, 20 Feb 2002 19:19:03 -0500
Date: Thu, 21 Feb 2002 00:19:00 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Allan Sandfeld <linux@sneulv.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: Idiot-proof APIC?
In-Reply-To: <20020220224952.GB20060@matchmail.com>
Message-ID: <Pine.LNX.4.44.0202210017280.340-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Mike Fedyk wrote:

> On Wed, Feb 20, 2002 at 08:07:47PM +0100, Allan Sandfeld wrote:
> > Hi, I just want to share some of my stupidity and my experience with it with 
> > you. 
> > I recently had the misfortune to try to put two celerons on an SMP-board. The 
> > bios correctly ignored the second cpu, but the linux-kernel(2.4.17). Would 
> > boot almost normally then emit two APIC-errors to the console(error 2 and 
> > 6?), and shortly after freeze completely.

<snip>
> 
> Actually, with the correct adapters, celerons can be made SMP safe.
> 
> I would immagine that it is hard to detect if there is a adapter operating
> correctly from the APIC code...

Only have to agree with Mike here.  I made the hardware mod to two 
slot-A celerons and haven't had any trouble at all from the machine.

If this is 'fixed', hopefully a command-line override will be added!

Mark

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

