Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAKK7A>; Thu, 11 Jan 2001 05:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbRAKK6u>; Thu, 11 Jan 2001 05:58:50 -0500
Received: from mail.lin-gen.com ([195.64.80.162]:50560 "EHLO server")
	by vger.kernel.org with ESMTP id <S129406AbRAKK6o>;
	Thu, 11 Jan 2001 05:58:44 -0500
Date: Thu, 11 Jan 2001 11:58:33 +0100
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drivers under 2.4
Message-ID: <20010111115833.A27971@lin-gen.com>
Reply-To: dth@lin-gen.com
In-Reply-To: <20010110223836.A7321@gruyere.muc.suse.de> <Pine.LNX.4.30.0101110003020.30013-100000@prime.sun.ac.za> <93k1k0$87v$1@voyager.cistron.net> <20010111113134.A20569@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010111113134.A20569@gruyere.muc.suse.de>; from ak@suse.de on Thu, Jan 11, 2001 at 11:31:34AM +0100
X-NCC-RegID: com.lin-gen
From: Danny ter Haar <dth@lin-gen.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



According to Andi Kleen:
> "Doesn't work" isn't a very useful bug report. What happens exactly?
> Do the RX/TX/error counters increase when you try to send packets? 


no, the counters you see with ifconfig eth0 are set to zero
for rx and to 1 for tx.

So it's trying to send out data but somehow it doesn't work.
Since the driver version is the same (althoud the output is
slihtly different which seems odd) i suspect the PCI
probing to be folded somewhere.

How could i provide people with more info ?

Thanks,

Danny
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
