Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280191AbRLFSUe>; Thu, 6 Dec 2001 13:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281915AbRLFSUY>; Thu, 6 Dec 2001 13:20:24 -0500
Received: from quechua.inka.de ([212.227.14.2]:18720 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S280191AbRLFSUL>;
	Thu, 6 Dec 2001 13:20:11 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ARP shows client is given wrong MAC Address for system with 2 NICs
In-Reply-To: <Pine.LNX.3.95.1011205135505.8200A-100000@chaos.analogic.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.16-xfs (i686))
Message-Id: <E16C37Y-0007hy-00@calista.inka.de>
Date: Thu, 06 Dec 2001 19:19:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1011205135505.8200A-100000@chaos.analogic.com> you wrote:
> You can delete the old entries from your ARP cache, but it has to
> be done for every system that would be affected or you can just wait
> for the ARP cache entry to expire.

>    /sbin/arp -d ipaddress

You can also advertise your new ARP Address. This is typically known as
gratious arp and is used within duplicate address detection. Most systems
will update their cache. You can use arping on Linux to do that (and more).

Greetings
Bernd
