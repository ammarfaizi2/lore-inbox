Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbQLERdg>; Tue, 5 Dec 2000 12:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129895AbQLERd0>; Tue, 5 Dec 2000 12:33:26 -0500
Received: from [216.161.55.93] ([216.161.55.93]:4339 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129881AbQLERdI>;
	Tue, 5 Dec 2000 12:33:08 -0500
Date: Tue, 5 Dec 2000 09:02:39 -0800
From: Greg KH <greg@wirex.com>
To: "J. Nick Koston" <lists@bdraco.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nightly usb oops
Message-ID: <20001205090239.A20542@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	"J. Nick Koston" <lists@bdraco.org>, linux-kernel@vger.kernel.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDD2@orsmsx31.jf.intel.com> <20001205041218.A11997@bdraco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001205041218.A11997@bdraco.org>; from lists@bdraco.org on Tue, Dec 05, 2000 at 04:12:18AM -0500
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 04:12:18AM -0500, J. Nick Koston wrote:
> hub.c: already running port 3 disabled by hub (EMI?), re-enabling...
> usb.c: USB disconnect on device 6
> hub.c: USB new device connect on bus1/2/3, assigned device number 11
> printer.c: usblp1: USB Bidirectional printer dev 11 if 0 alt 1
> usb.c: USB disconnect on device 11

<disconnect and reconnect repeating snipped>

Ouch!  Unplug that printer!  Either the printer connection is bad, or
your hub that the printer is plugged into is bad.  My guess is on the
hub.  Is this hub powered from an external power supply?

You also might want to try a different port on that hub to see if that
is any better.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
