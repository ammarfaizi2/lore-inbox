Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbTA1Oow>; Tue, 28 Jan 2003 09:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267337AbTA1Oov>; Tue, 28 Jan 2003 09:44:51 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:50119 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267334AbTA1Oou> convert rfc822-to-8bit; Tue, 28 Jan 2003 09:44:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Wichert Akkerman <wichert@wiggy.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Date: Tue, 28 Jan 2003 15:53:45 +0100
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com> <1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk> <20030128143235.GY4868@wiggy.net>
In-Reply-To: <20030128143235.GY4868@wiggy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301281553.45815.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. Januar 2003 15:32 schrieb Wichert Akkerman:
> Previously Alan Cox wrote:
> > I'd not really pondered people who compile many drivers into their kernel
> > instead of into the initrd. I guess a few people still do that.
>
> Agreed - what you probably want to do is have a minimal kernel that
> boots an initrd which loads modules for the rest. If the kernel is

Why? If you do an embedded system you go for minimal memory.
You'd probably compile a kernel without module support. You know
which hardware is to be supported, so you gain nothing at all
by using modules.
Frankly, even for a normal system, why compile an initrd for drivers
you need during everyday operation? If you compile yourself at all, why
pay the price in memory and TLB misses?

	Regards
		Oliver

