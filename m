Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130869AbRAKLaB>; Thu, 11 Jan 2001 06:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRAKL3v>; Thu, 11 Jan 2001 06:29:51 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:20399 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129406AbRAKL3m>; Thu, 11 Jan 2001 06:29:42 -0500
Message-ID: <3A5D9AB1.39F6627C@uow.edu.au>
Date: Thu, 11 Jan 2001 22:36:17 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: dth@lin-gen.com
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Drivers under 2.4
In-Reply-To: <20010110223836.A7321@gruyere.muc.suse.de> <Pine.LNX.4.30.0101110003020.30013-100000@prime.sun.ac.za> <93k1k0$87v$1@voyager.cistron.net> <20010111113134.A20569@gruyere.muc.suse.de>,
		<20010111113134.A20569@gruyere.muc.suse.de>; from ak@suse.de on Thu, Jan 11, 2001 at 11:31:34AM +0100 <20010111115833.A27971@lin-gen.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar wrote:
> 
> According to Andi Kleen:
> > "Doesn't work" isn't a very useful bug report. What happens exactly?
> > Do the RX/TX/error counters increase when you try to send packets?
> 
> no, the counters you see with ifconfig eth0 are set to zero
> for rx and to 1 for tx.
> 
> So it's trying to send out data but somehow it doesn't work.
> Since the driver version is the same (althoud the output is
> slihtly different which seems odd) i suspect the PCI
> probing to be folded somewhere.
> 
> How could i provide people with more info ?

There's a "reporting problems" section at the end
of Documentation/networking/vortex.txt.  Should help.

Probably the most important thing is inserting the driver
module with `debug=7', opening the device, sending some
traffic and then sending us the logs.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
