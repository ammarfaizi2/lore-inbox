Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbSK1XwD>; Thu, 28 Nov 2002 18:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbSK1XwD>; Thu, 28 Nov 2002 18:52:03 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:3591 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S266865AbSK1XwC>; Thu, 28 Nov 2002 18:52:02 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: connectivity to bkbits.net?
Date: Thu, 28 Nov 2002 23:59:24 +0000 (UTC)
Organization: Cistron
Message-ID: <as6aks$amj$1@ncc1701.cistron.net>
References: <200211281625.gASGPo804227@work.bitmover.com> <8aiMdRMXw-B@khms.westfalen.de> <20021128211347.D27234@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1038527964 10963 62.216.29.67 (28 Nov 2002 23:59:24 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021128211347.D27234@flint.arm.linux.org.uk>,
Russell King  <rmk@arm.linux.org.uk> wrote:
>On Thu, Nov 28, 2002 at 06:53:00PM +0200, Kai Henningsen wrote:
>> >From two or three traceroutes, that problem seems to be at the SGI end. I  
>> can't get to them either (nothing after the same IP as for you, at hop  
>> #17, some place at Genuity), but you are practically next door.
>
>Lesson #1 of firewalling: drop everything.
>Lesson #2 of firewalling: only accept what you absolutely have to.

Lesson#3 of firewalling: due to #1 and #2 most admins block
ICMP_UNREACH_NEEDFRAG as well (ICMP == ping == bad) breaking
path MTUd. http://alive.znep.com/~marcs/mtu/

Note that IPv6 has no fragmentation and pMTUd is mandatory.
Oh joy.

Mike.
-- 
They all laughed when I said I wanted to build a joke-telling machine.
Well, I showed them! Nobody's laughing *now*! -- acesteves@clix.pt

