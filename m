Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbREOWvi>; Tue, 15 May 2001 18:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261684AbREOWv2>; Tue, 15 May 2001 18:51:28 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:16032 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261683AbREOWvU>; Tue, 15 May 2001 18:51:20 -0400
Date: Tue, 15 May 2001 15:49:44 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: LANANA: To Pending Device Number Registrants
To: jsimmons@transvirtual.com
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <045e01c0dd91$56a7ae40$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I couldn't agree with you more. It gives me headaches at work. One note, 
> > > their is a except to the eth0 thing. USB to USB networking. It uses usb0, 
> > > etc. I personally which they use eth0. 
> > 
> > USB to USB networking cables aren't ethernet. 
>
> I'm talking about a wireless connection. ipaq USB cradle to PC. 

Sounds rather wire-ful to me ... :)

It's not an Ethernet, which is why it doesn't masquerade as one.
At least, not more than necessary to interop with at least one set
of Win32 drivers.  (And one hopes, more in the future.)

Until there's some way that network interfaces can expose more
information to sysadmin tools, it seems smarter to set things up
so they can't confuse USB and Ethernet links.  Scripts can "know"
the various differences, and accomodate more.  One example
that's come up:  an MTU closer to two USB 1.1 frames will
give better throughput at negligible cost, other than precluding
some bridging setups involving N-BaseT.

- Dave




