Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272548AbRIFUQR>; Thu, 6 Sep 2001 16:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272543AbRIFUQH>; Thu, 6 Sep 2001 16:16:07 -0400
Received: from spike.porcupine.org ([168.100.189.2]:50186 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S272548AbRIFUP5>; Thu, 6 Sep 2001 16:15:57 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
In-Reply-To: <E15f57F-0000L2-00@the-village.bc.nu> "from Alan Cox at Sep 6, 2001
 08:47:09 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 6 Sep 2001 16:16:17 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, Steve VanDevender <stevev@efn.org>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906201617.60F60BC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> > If the kernel knows about subnets, then an application should be
> > able to find out about them. Whether or not you agree with the
> > application's reasons does not matter.
> 
> There I agree - entirely. I'd also say that an application using legacy
> 4.3BSD API's ought to get correct answers for configurations which are
> validly expressed in that specific worldview

Putting on a different hat, that of forensics and auditing, I would
claim that such functionality is useful for every API. If something
can be set, then there must be a corresponding way to find out.

For settings created with *netlink, it is entirely reasonable to
use the *netlink API to query its state. It's just a pain in the
butt for people like me to find out and advise users.

	Wietse
