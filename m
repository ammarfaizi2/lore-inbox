Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271718AbRIGLOA>; Fri, 7 Sep 2001 07:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271719AbRIGLNu>; Fri, 7 Sep 2001 07:13:50 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:20239 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271718AbRIGLNh>; Fri, 7 Sep 2001 07:13:37 -0400
Date: Fri, 7 Sep 2001 13:13:57 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010907131357.D13826@emma1.emma.line.org>
Mail-Followup-To: hps@intermeta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20010906204104.A3FBDBC06C@spike.porcupine.org> <Pine.GSO.4.30.0109061643030.14727-100000@shell.cyberus.ca> <20010906232033.L13547@emma1.emma.line.org> <9na3o5$c9$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9na3o5$c9$1@forge.intermeta.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmiedehausen schrieb am Freitag, den 07. September 2001:

> So you actually say "make it the way BSD does, because that's what we
> know and support". Sheesh. Why don't you just use Netlink and start
> preaching to the BSD and Solaris folks that "this is the way how it
> should be done". I'd say there are more Linux machines than BSD and
> Solaris combined out there.

I assume you know the meaning of the words "bloat" and "proliferation".

A portable application needs the BSD interface anyhow, and adding
another interface just for Linux makes it a testing/maintenance and thus
a reliability nightmare.

I wouldn't call the netlink example that's been posted here "trivial"
with its 215 lines.  You don't seriously expect a portable program to
add 200 lines of C to pull 5 bits of entropy out of the Linux kernel
where ANY other kernel does it with 4 lines of C, and Linux could do it
as well.

If people only commented (not flamed) constructively on my patch rather
than adding fuel to this unnecessary fire.

The Big Silence[TM].
