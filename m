Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274189AbRISVNh>; Wed, 19 Sep 2001 17:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274191AbRISVN0>; Wed, 19 Sep 2001 17:13:26 -0400
Received: from ns2.cypress.com ([157.95.67.5]:129 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S274189AbRISVNW>;
	Wed, 19 Sep 2001 17:13:22 -0400
Message-ID: <3BA90A57.6090803@cypress.com>
Date: Wed, 19 Sep 2001 16:12:55 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.3) Gecko/20010806
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, 
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: Re: NFS in 2.4.8/9ac
In-Reply-To: <3B8EA974.9060201@cypress.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thomas Dodd wrote:
> I've suddenly started getting host not responding messages
> on NFS mounts. The mounts are from Solaris8 and HPUX-10.20.
> Other Solaris8 machines don't have this problem,
> and the machines serving the mounts are unloaded, and responsive.

> Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
> tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
> eth0: Lite-On 82c168 PNIC rev 33 at 0xe400, 00:A0:CC:50:35:C2, IRQ 10
> (Tulip FA310TX card)
> NETDEV WATCHDOG: eth0: transmit timed out
> nfs: server nd not responding, still trying

Just a note: This is still a problem.
eventually I'll get a message about task slots.

It's still there through 2.4.9-ac10.

On a new Athlon 1.4 box, with a LNE100TX NIC
it's there with the default kernel from Red Hat Linux 7.1
(2.4.2-2.i686.rpm), and on a P4-1.8GHz with the same NIC.

The servers are Solaris8 and Solaris-2.6, Sparc machines, and the config
hasn't changed in over a year on the 2.6 boxes.

Anorthe system with RHL-6.2 (2.2.14-5 kernel and eepro100 NIC)
has no trouble talking to the servers.

What/how do I set debugging code on the 2.4 kernels to trak
down this problem? It makes NFS mounted home dirs unusable.

	-Thomas


