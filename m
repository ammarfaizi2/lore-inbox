Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269547AbRHHWFR>; Wed, 8 Aug 2001 18:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269580AbRHHWFH>; Wed, 8 Aug 2001 18:05:07 -0400
Received: from imladris.infradead.org ([194.205.184.45]:64521 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269547AbRHHWE5>;
	Wed, 8 Aug 2001 18:04:57 -0400
Date: Wed, 8 Aug 2001 23:04:31 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: <ankry@green.mif.pg.gda.pl>, Mark Atwood <mra@pobox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <m11ymmvn5o.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0108082302060.12565-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric.

 >> 1. NFS-root needs to have RARP/NFS servers on eth0.

 >> How can you deal with it if you have two boards supported by a
 >> single driver and, unfortunately, the one you need is detected
 >> as eth1 ? Assume that you cannot switch them as they use
 >> different media type...

 > Hmm. Then my system that does DHCP/NFS root with 2.4.7 and comes
 > up on eth2 is doesn't work?  Hmm it looks like it works to me.

I have no personal experience of NFS-Root but the documentation I've
seen all implied that it did the RARP broadcast in parallel on all
configured NIC's and used the one that replied from there on. I'm glad
to hear that my reading of the documentation was correct.

Best wishes from Riley.

