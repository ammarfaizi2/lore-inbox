Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271283AbRIFP6V>; Thu, 6 Sep 2001 11:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271309AbRIFP6M>; Thu, 6 Sep 2001 11:58:12 -0400
Received: from spike.porcupine.org ([168.100.189.2]:28937 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S271283AbRIFP5v>; Thu, 6 Sep 2001 11:57:51 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
 bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906193750.B22187@castle.nmd.msu.ru> "from Andrey Savochkin
 at Sep 6, 2001 07:37:50 pm"
To: Andrey Savochkin <saw@saw.sw.com.sg>
Date: Thu, 6 Sep 2001 11:58:11 -0400 (EDT)
Cc: Matthias Andree <matthias.andree@gmx.de>,
        Wietse Venema <wietse@porcupine.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906155811.BC78DBC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin:
> Of course, SIOCGIFCONF isn't even close to provide the list of local
> addresses.
> Obvious example: it doesn't enlist all addresses 127.0.0.1, 127.0.0.2 etc.
> on common systems.  If you handle 127.0.0.2 as local, you apply side

127.0.0.2 is not local on any of my systems. The only exceptions
are some Linux boxen that I did not ask to do so.

I welcome suggestions, maybe even code fragments, that will allow
an MTA to correctly recognize user@[ip.address] as local, as required
by the SMTP RFC.

> On Thu, Sep 06, 2001 at 04:17:49PM +0200, Matthias Andree wrote:
> > I'm not sure where and why you deduce the idea this is about MTA loop
> > detection or peer recognition.
> 
> Because it's the obvious reason to start to be aware about networking
> configuration, and all MTAs known to me try to do it.
> 
> All other reasons are absolutely artificial.

It is perfectly OK for an MTA to make a distinction between local
subnets and the rest of the Internet.

I welcome suggestions, maybe even code fragments, that will allow
an MTA to correctly recognize the subnetworks that the machine is
attached to.

	Wietse
