Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272609AbRIFVUm>; Thu, 6 Sep 2001 17:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272607AbRIFVUd>; Thu, 6 Sep 2001 17:20:33 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:60165 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272606AbRIFVUP>; Thu, 6 Sep 2001 17:20:15 -0400
Date: Thu, 6 Sep 2001 23:20:33 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: jamal <hadi@cyberus.ca>
Cc: Wietse Venema <wietse@porcupine.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kuznet@ms2.inr.ac.ru, Matthias Andree <matthias.andree@gmx.de>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010906232033.L13547@emma1.emma.line.org>
Mail-Followup-To: jamal <hadi@cyberus.ca>,
	Wietse Venema <wietse@porcupine.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
In-Reply-To: <20010906204104.A3FBDBC06C@spike.porcupine.org> <Pine.GSO.4.30.0109061643030.14727-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0109061643030.14727-100000@shell.cyberus.ca>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001, jamal wrote:

> Which part dont you understand?
> 
> Youve been told about 1000 times already, but let me shout:
> 
> YOU CAN GET THE INFORAMTION YOU WANT IF YOU USE NETLINK.

Calm down. Please. This discussion is about portability. I'm not
striving to turn Linux into FreeBSD, and neither is Wietse.

Not personally addressed to anyone, but for all Linux hackers to
consider are the following parts:

See it from the user-space programmer's point of view. Imagine you're
developing your software on FreeBSD or Solaris, or whatever. Now imagine
a client/user asks you about Linux support. You figure Linux does an
ioctl differently than BSD - that's all you see in the first place. You
start wondering, tracking, debugging, end up reading kernel sources, and
you see the difference. You go for support, and all you hear is "well,
we want to keep this non-portable for egoistic compatibility reasons,
use netlink instead". As to netlink, "go get ip of iproute2 and see how
it does things".

The programmer of a portable application is annoyed and frustrated
because it's just another fucking subtle API difference, and it
coincides with a boggled and outdated netdevice(7) man page.

It's not a sign of quality if Linux man pages are updated months after
the code either.

Does anyone think these issues help Linux or get Linux anywhere except
to bad reputation?

There are a lot of competent people with their hands on Linux, and
generally, Linux works well, and people are helpful, but sometimes,
developers seem to lose the more global view. Linux is not longer an end
in itself. Please don't let portability slip from your view.
