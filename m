Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRH1UJa>; Tue, 28 Aug 2001 16:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbRH1UJU>; Tue, 28 Aug 2001 16:09:20 -0400
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:44553 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S267852AbRH1UJB>;
	Tue, 28 Aug 2001 16:09:01 -0400
From: "Tony Hoyle" <tmh@nothing-on.tv>
Subject: Treating parallel port as serial device
Date: Tue, 28 Aug 2001 21:09:12 +0100
Organization: Magenta netLogic
Message-ID: <9mgtpb$mf4$1@sisko.my.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: sisko.my.home 999029355 23012 192.168.100.2 (28 Aug 2001 20:09:15 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Pan/0.10.0 (Unix)
X-Comment-To: ALL
X-No-Productlinks: Yes
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking to attach a serial device to my box that has only TTL level
I/O.  Since I'm more of a software than a hardware person making a
circuit board up with a max232 in is a bit risky...  I want to connect
the I/O to the parallel port.

What I need now is a driver that can read the input from a  pin on the
parallel port and treat it as serial input.  It sounds like the kind of
project that would have been done before, but I can't find anything that
even comes close.  Userspace probably wouldn't cut it as I'm reading as
9600 baud and usleep doesn't have nearly enough resolution.

Tony

-- 
Microsoft - two out of three dead people who expressed a preference
said their coffins preferred it.

tmh@nothing-on.tv	http://www.nothing-on.tv
