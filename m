Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278225AbRKAH4f>; Thu, 1 Nov 2001 02:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278261AbRKAH4Y>; Thu, 1 Nov 2001 02:56:24 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:56846 "HELO due.stud.ntnu.no")
	by vger.kernel.org with SMTP id <S278225AbRKAH4N>;
	Thu, 1 Nov 2001 02:56:13 -0500
Date: Thu, 1 Nov 2001 08:55:23 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
Message-ID: <20011101085523.D2102@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no> <20011031182212.A21776@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031182212.A21776@castle.nmd.msu.ru>; from saw@saw.sw.com.sg on Wed, Oct 31, 2001 at 06:22:13PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin:
> Well, with eepro100 the start may be the following:
> 1. When the card stalls, start ping from that host.
> This way you ensure that you have something in transmit ring.
> If it's transmitting that stalls, you'll get a message from netdev watchdog.

>From the server, or the client?  I've already tried pinging from the server
when I get the error-message in dmesg, but it's unresponsive to anything.
And, I mean anything, network-wise. There seems to be a timeout somewhere,
because after some time, everything resumes back to normal again.

> 4. In any case, running eepro100-diag from scyld.com at the moment of the
> stall may give some useful information.

OK, I'll do the test again, and run the eepro100-diag. Any special options
you want me to specify?

> 5. In any case, searching eepro100 mailing list archive on scyld.com is a
> good idea, you may learn what other people observe/do.

OK, I'll search... :)

-- 
Thomas
