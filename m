Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUIUUJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUIUUJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUIUUJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:09:08 -0400
Received: from mta01.mail.tds.net ([216.170.230.81]:33928 "EHLO
	mta01.mail.tds.net") by vger.kernel.org with ESMTP id S268043AbUIUUI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:08:59 -0400
Date: Tue, 21 Sep 2004 15:09:29 -0500 (CDT)
From: David Lloyd <dmlloyd@tds.net>
To: David Woodhouse <dwmw2@infradead.org>
cc: SashaK <sashak@smlink.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97  
 patch)
In-Reply-To: <1095785705.17821.760.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.60.0409211504440.7029@tomservo.workpc.tds.net>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se> 
 <20040912011128.031f804a@localhost> <1095785705.17821.760.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004, David Woodhouse wrote:

> On Sun, 2004-09-12 at 01:11 +0300, SashaK wrote:
>> This is exactly that was discussed - 'slamr' is going to be replaced by
>> ALSA drivers. I don't know which modem you have, but recent ALSA
>> driver (CVS version) already supports ICH, SiS, NForce (snd-intel8x0m),
>> ATI IXP (snd-atiixp-modem) and VIA (snd-via82xx-modem) AC97 modems.
>
> What chance of making it work with the ISDN drivers? Should we make an 
> ALSA driver for ISDN?

That's an interesting idea.  Some thoughts I'd have off the bat:

- I don't think there's a software modem implementation (free or
   otherwise) for linux that can support the server side of a digital
   (v.90, v.92) connection, but that would be excellent to have

- Americans might have an FCC concern due to power output restrictions on
   digital modem protocols, and also other voice applications

- Presumably it would only make sense to do this with voice connections

- Could this idea be extended to analog telephony devices?

