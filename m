Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286925AbSA2QNS>; Tue, 29 Jan 2002 11:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289730AbSA2QNJ>; Tue, 29 Jan 2002 11:13:09 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:54954 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S286925AbSA2QM7>; Tue, 29 Jan 2002 11:12:59 -0500
Date: Tue, 29 Jan 2002 17:12:47 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: Dead loop on virutal device.
Message-ID: <20020129171247.A580@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I'm using a 2.4.17 (upgrade from a 2.2.16), I get this
message:

Dead loop on virtual device tun1, fix it urgently!

Sometimes it's there a short time between them, other times a
long time.

I got no idea what's causing them.

I tried looking at the source and it says something about
recursion and something about SMP.  This is not an SMP box.

The device in question is a tunnel device, it does ipv6 over
ipv4.  Most traffic goes thru that one.  It's the only one that
generates that message.

It says to fix it urgently, but I don't know how, and it seems to
work fine otherwise.

Do you know what is wrong and how I can fix this?


Kurt

