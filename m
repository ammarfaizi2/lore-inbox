Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRDPQ0J>; Mon, 16 Apr 2001 12:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRDPQZ7>; Mon, 16 Apr 2001 12:25:59 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:20787 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S131307AbRDPQZq>; Mon, 16 Apr 2001 12:25:46 -0400
Date: Mon, 16 Apr 2001 18:25:38 +0200 (CEST)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
cc: Pavel Machek <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <20010416174945.D29398@kallisto.sind-doof.de>
Message-Id: <Pine.LNX.4.31.0104161816470.19209-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, Andreas Ferber wrote:

> > A power failure is a different thing from a power button press.

> And why not do exactly this with init? Have a look in /etc/inittab:

> You can shut down your machine there, but you can also have it play a
> cancan on power failure. It is up to your gusto. And now tell me, why
> not choose a similar approach, but instead reinvent the wheel and
> create a completely new mechanism?

Because we'd be running out of signals soon, when all the other ACPI
events get available.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

