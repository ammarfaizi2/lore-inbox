Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319394AbSHWU3d>; Fri, 23 Aug 2002 16:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319392AbSHWU3b>; Fri, 23 Aug 2002 16:29:31 -0400
Received: from windsormachine.com ([206.48.122.28]:42769 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S319390AbSHWU32>; Fri, 23 Aug 2002 16:29:28 -0400
Date: Fri, 23 Aug 2002 16:33:29 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Bill Unruh <unruh@physics.ubc.ca>
cc: <linux-ppp@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.33L2.0208230905440.16602-100000@string.physics.ubc.ca>
Message-ID: <Pine.LNX.4.33.0208231619360.21045-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Bill Unruh wrote:

>
> OK, that problem is usually a "hardware" problem-- ie the hardware is
> not responding properly to the icotl request. This could be because
> there is not hardware there (eg trying to open a serial port which does
> not exist on the machine), or is busy, or has been left in some weird
> state. The last sounds most likely here-- eg the serial port on your
> modem thinks it is still busy.
>
> You could try running the little program I got basically from Carlson in
> http://axion.physics.ubc.ca/modem-chk.html
> to try resetting the serial line befor the next attempt (eg, put it into
> /etc/ppp/ip-down).
> Not sure if this is the problem however.

Another 7 minutes, and I'll know if this worked or not.

Another data point I just thought of, if i poff chatham, and then pon
chatham, that actually works.

It just hung up.

And redialed.

And connected properly.

Thank you so very much, it looks like your reset-serial did the job.

I'll implement it on future machines, just in case the same problem
happens, rather than pray it works.

I saw a lot of postings on the 5160 USR modem on the serial-pci-info list,
perhaps it's something to do with this modem.

I'll know for sure at 10:30 this evening, if it is definately owrking or
not.  I was logged in on the other line to monitor the syslog, and bring
up the internet line, just in case.

Thanks again,

Mike

