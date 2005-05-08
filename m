Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVEHL6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVEHL6f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 07:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVEHL6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 07:58:35 -0400
Received: from smtpout2.uol.com.br ([200.221.4.193]:38552 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S262852AbVEHL6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 07:58:33 -0400
Date: Sun, 8 May 2005 08:58:20 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org,
       Roman Zippel <zippel@linux-m68k.org>, Brad Boyer <flar@allandria.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Oops and BUG's with hfsplus module
Message-ID: <20050508115820.GA6640@ime.usp.br>
Mail-Followup-To: Colin Leroy <colin@colino.net>,
	linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org,
	Roman Zippel <zippel@linux-m68k.org>,
	Brad Boyer <flar@allandria.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20050507235454.GA16058@ime.usp.br> <20050508114839.44ed10dc@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050508114839.44ed10dc@jack.colino.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 08 2005, Colin Leroy wrote:
> On 07 May 2005 at 20h05, Rogério Brito wrote:
> > Yesterday, I got a quite scary ooops and, today, after trying a newer
> > kernel, I got many messages in my dmesg logs.
> 
> I've had problems mounting my iPod with Firewire, whereas USB works ok.
> Do you have the ability to test an hfsplus filesystem over usb-storage?

Yes, I have. This is a dual Firewire/USB enclosre. I can test with
usb-storage, but I had really scary problems with it some time ago (like it
saying that the media from my HD was removed --- when it obviously wasn't
and, to top it off, I could reproduce it, but it was with kernels like
2.6.7 or so).

I think that I can also try some stress tests with an ext2/ext3 filesystem
and Firewire (i.e., trying to rule out the hfsplus variable from the
problem).

> Maybe the problem comes from sbp2.

Yes, that can't be ruled out, but the messages all mentioned the problem
inside the hfsplus module. I will test it anyway.

> Also, can you try with 2.6.12-rc4?

Yes, I will recompile a newer copy as soon as I get up (it's really early
in the morning here and I need to sleep now).

Anyway, if any further information is necessary, please let me know.


Thanks for the prompt response, Rogério Brito.


-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
