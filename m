Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286145AbRLZET7>; Tue, 25 Dec 2001 23:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286150AbRLZETt>; Tue, 25 Dec 2001 23:19:49 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:7363 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S286148AbRLZETj>;
	Tue, 25 Dec 2001 23:19:39 -0500
Message-ID: <3C29FA05.6C1BED5A@sltnet.lk>
Date: Wed, 26 Dec 2001 10:25:41 -0600
From: Alvin of Diaspar <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] A slightly smarter dmi_scan.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > APM can also be compiled as a module.
> >
> > Right. Thanks. I blatantly ignored that APM can be built as modules ;(
> > The fixed patch is here.
  
> I think I prefer it without all the ifdefs being in the code like that. It is
> cleaner to read before the change. I agree the messages being printed might
> be confusing in some cases but I don't like the cure.

	I agree. The code in dmi_scan.c runs very elegantly now, and changing
that flow, although might be more efficient by something like 0.001%,
isn't worth the touble.
	Sorry about adding to the ambient background radiation :)

	- ioj

~~~~
    Ask not of race, but ask of conduct: 
    From the stick is born the sacred fire:
    The wise ascetic, though lowly born,
    Is noble in his modest self-control.
                - Gotama Buddha
.
