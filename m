Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281923AbRLFSZz>; Thu, 6 Dec 2001 13:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282042AbRLFSZk>; Thu, 6 Dec 2001 13:25:40 -0500
Received: from quechua.inka.de ([212.227.14.2]:28704 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S281923AbRLFSZU>;
	Thu, 6 Dec 2001 13:25:20 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: transparent firewall??
In-Reply-To: <5.0.2.1.0.20011205114948.01a65410@pop.mail.yahoo.fr>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.16-xfs (i686))
Message-Id: <E16C3Cp-0007jf-00@calista.inka.de>
Date: Thu, 06 Dec 2001 19:25:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <5.0.2.1.0.20011205114948.01a65410@pop.mail.yahoo.fr> you wrote:
> I'd like to know if anyone has a transparent firewall that is one that 
> doesn't make any rules on the traffic but only always pass it without this 
> beeing notified by the rest of the network system...

There are 2 ways to add a computer into the stream (besides sniffing), you
can set up a bridge, it is forwarding packets without having to have a own
ip address and without the need of reconfiguration. Of course you can use a
router to do the same, it just needs routing table modifications.

If you want to look at the data stream on an application on a (TCP) socket
level, you can use the transproxy function of linux kernel. It will redirect
a connection which is done through a router to any local process. Those
local process then can contact the original destination, having effectively
beeing a man in the middle. There are a lot of tools out there to do this.

You may want to tell us, what you are trying to do.

Greetings
Bernd
