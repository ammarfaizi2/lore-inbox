Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVFUVg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVFUVg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVFUVd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:33:57 -0400
Received: from god.demon.nl ([83.160.164.11]:17793 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S262554AbVFUVaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:30:17 -0400
Date: Tue, 21 Jun 2005 23:30:09 +0200
From: Henk <Henk.Vergonet@gmail.com>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new 7-segments char translation API
Message-ID: <20050621213009.GA2122@god.dyndns.org>
References: <20050531220738.GA21775@god.dyndns.org> <429DAB07.1050900@anagramm.de> <20050604204403.GA10417@god.dyndns.org> <20050605005329.70d9461a.froese@gmx.de> <20050606092608.GA16471@god.dyndns.org> <20050606091942.2c31bb98.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050606091942.2c31bb98.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 09:19:42AM -0700, randy_dunlap wrote:
> On Mon, 6 Jun 2005 11:26:08 +0200 Henk wrote:
> 
> | On Sun, Jun 05, 2005 at 12:53:29AM +0200, Edgar Toernig wrote:
> | > By your reasoning /usr/dict/words had to be in the kernel,
> | > too.
> | 
> | Well by my reasoning you should, if possible, define some usefull
> | standards that will allow te reuse of these dictionaries within other
> | applications.
> | 
> | And while we're on the subject of whats IN or OUT, (and I'll bet if you
> | ask 10 kernel developers you'll get 10 answers but I try anyway ;)
> | 
> | In my philosophy the OS (kernel + device drivers) is an abstraction of
> | the machine, it should present the 'machine' in such a way that allows
> | for other abstractions such as a word processor to operate without having
> | to know the specifics of hardware devices.
> 
> The abstraction also includes libraries, and if lib7segment
> could do this from userspace, that's where it should reside.
> I'm not saying that it can, but if it can, then that's the
> desired place for it.
> 
Sorry for the late response,

The patch that was at the beginning of this thread is just a standard,
and just enough so a userspace program would never have to know anything
about 7 segments. And its just enough a device driver that needs to know
about this can implement it in a way that is portable and standardised.

I would, with all the love of the world create an userspace lib7segment for
you guys, but all I can think of is just this linux include file.


Well I think that the real issue here is that many of the kernel
developers feel that there´s to much fluff & features in the kernel
already.

>From an operational perspective I imagine its becomming harder and harder
to manage kernel code so I can understand people when they are
saying f**k off with 7-segments Ive got bigger fish to fry.

No offense taken, I just hope I didnt offend anyone either.

Ill be back,)

Henk Vergonet

