Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSJaSQ5>; Thu, 31 Oct 2002 13:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSJaSQ5>; Thu, 31 Oct 2002 13:16:57 -0500
Received: from [202.54.110.230] ([202.54.110.230]:10250 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id <S263188AbSJaSQI>; Thu, 31 Oct 2002 13:16:08 -0500
Message-ID: <E04CF3F88ACBD5119EFE00508BBB2121053DD18E@exch-01.noida.hcltech.com>
From: "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: RE: [lkcd-devel] Re: What's left over.
Date: Thu, 31 Oct 2002 23:47:38 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus Torvalds wrote:
> 
> > 	In particular when it comes to this project, I'm told about
> > 	"netdump", which doesn't try to dump to a disk, but 
> over the net.
> > 	And quite frankly, my immediate reaction is to say "Hell, I
> > 	_never_ want the dump touching my disk, but over the network
> > 	sounds like a great idea".
> > 
> > To me this says "LKCD is stupid". Which means that I'm not 
> going to apply 
> > it, and I'm going to need some real reason to do so - ie 
> being proven 
> > wrong in the field.
> 
> How do you deal with netdump when your network driver is what 
> caused the 
> crash?
> 
> Ideally I would like to see a dump framework that can have a 
> number of 
> possible dump targets.  We should be able to dump to any 
> combination of 
> network, serial, disk, flash, unused ram that isn't wiped 
> over restarts, 
> etc...
This is what the LKCD with generic interface is .. LKCD with generic
interface has the capability to include various dump targets in a very clean
way. Originally the LKCD meant for saving dump only on the disks, but its
generic interface has provided the option to have a number of dump targets.

Regards
Deepak.
