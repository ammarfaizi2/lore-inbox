Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265215AbRFUUtC>; Thu, 21 Jun 2001 16:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265217AbRFUUsw>; Thu, 21 Jun 2001 16:48:52 -0400
Received: from force.4t2.com ([195.230.37.100]:29218 "EHLO force.4t2.com")
	by vger.kernel.org with ESMTP id <S265215AbRFUUsq>;
	Thu, 21 Jun 2001 16:48:46 -0400
To: linux-kernel@vger.kernel.org
Path: news.abyss.4t2.com!not-for-mail
From: x@abyss.4t2.com (Thomas Weber)
Newsgroups: 4t2.lists.linux.kernel
Subject: Re: 2.4.6pre iptables masquerading seems to kill eth0
Date: 21 Jun 2001 22:51:33 +0200
Organization: The Abyss of 4t2.com
Message-ID: <9gtmol$9ve$1@pandemonium.abyss.4t2.com>
In-Reply-To: <3B31A652.85D2E597@idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm on 2.4.6pre3 + freeswan/ipsec on my gateway now for 5 days.
It's an old 486/66 32MB with several isdn links, a dsl uplink (with 
iptables masquerading) behind a ne2k clone and a 3c509 to the inside network.
no problems at all with the interfaces (all compiled as modules).

  Tom

In article <3B31A652.85D2E597@idb.hist.no>,
Helge Hafting <helgehaf@idb.hist.no> wrote:
>I have a home network with two machines connected with
>3c905B cards.  The main machine also has a isdn dialup connection.
>
>Networking works well except if I let the main machine masquerade
>so the other can use the internet too.  I use iptables for this.
>It works for a day or so, then eth0 goes silent on the main machine.
>(Rebooting it shows that the other one was fine all the time.)
>
>The symptoms is that there is no contact between the two machines.
>No ping or anything.  "ifconfig" shows the interface is up
>with the correct ip address, but all packets just disappear.
>There are no error messages except from programs that time out.
>
>Bringing the interface down and up
>again with ifconfig does not help.  It is compiled into the
>kernel, so I can't try module reloading.
>
>Is this some sort of known problem? Or is there something
>I could do to find out more?  I couldn't
>find anything in the logfiles.
