Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271388AbRIFQu4>; Thu, 6 Sep 2001 12:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271413AbRIFQur>; Thu, 6 Sep 2001 12:50:47 -0400
Received: from spike.porcupine.org ([168.100.189.2]:36617 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S271388AbRIFQub>; Thu, 6 Sep 2001 12:50:31 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
 bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906204423.B23109@castle.nmd.msu.ru> "from Andrey Savochkin
 at Sep 6, 2001 08:44:23 pm"
To: Andrey Savochkin <saw@saw.sw.com.sg>
Date: Thu, 6 Sep 2001 12:50:51 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906165051.7EA29BC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin:
> > I welcome suggestions, maybe even code fragments, that will allow
> > an MTA to correctly recognize user@[ip.address] as local, as required
> > by the SMTP RFC.
> 
> The question was which ip.address in user@[ip.address] should be treated as
> local.
> My comment was that the only reasonable solution on Linux is to treat this
> way addresses explicitly specified in the configuration file.
> Postfix may show its guess at the installation time.

That is not practical. Surely there is an API to find out if an IP
address connects to the machine itself. If every UNIX system on
this planet can do it, then surely Linux can do it.

The same issue is true for local subnets. Surely there exists an
API to find out what subnetworks a machine is attached to. If every
UNIX system on this planet can do it, then surely Linux can do it.

	Wietse
