Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSJaSRv>; Thu, 31 Oct 2002 13:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSJaSRu>; Thu, 31 Oct 2002 13:17:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24074 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263270AbSJaSRm>; Thu, 31 Oct 2002 13:17:42 -0500
Date: Thu, 31 Oct 2002 10:22:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <3DC171FF.5000803@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0210311015380.1410-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002, Chris Friesen wrote:
> 
> How do you deal with netdump when your network driver is what caused the 
> crash?

Actually, from a driver perspective, _the_ most likely driver to crash is 
the disk driver. 

That's from years of experience. The network drivers are a lot simpler,
the hardware is simpler and more standardized, and doesn't do as many
things. It's just plain _easier_ to write a network driver than a disk
driver.

Ask anybody who has done both.

But that's not the real issue. The real issue is that I have no personal
incentives to try to merge the thing, and as a result I think I'm the
wrong person to do so. I've told people over and over again that I think
this is a "vendor merge", and I'm fed up with people not _getting_ it.

Don't bother to ask me to merge the thing, that only makes me get even
more fed up with the whole discussion. This is open source, guys. Anybody 
can merge it. Because I don't particularly believe in it doesn't mean that 
it cannot be used. It only means that I want to see users flock to it and 
show my beliefs wrong.

		Linus

