Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSL2NUI>; Sun, 29 Dec 2002 08:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSL2NUI>; Sun, 29 Dec 2002 08:20:08 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:2303 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266615AbSL2NUG>; Sun, 29 Dec 2002 08:20:06 -0500
Subject: Re: radeonfb.c has lots of undefined symbols
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rahul Jain <rahul@rice.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87hecxfhnf.fsf@localhost.localdomain>
References: <87hecxfhnf.fsf@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Dec 2002 14:30:25 +0100
Message-Id: <1041168625.526.20.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-29 at 07:44, Rahul Jain wrote:
> I just decided to make the leap to 2.5, and in the process of compiling,
> I hit a bug: Many of the PCI IDs are defined as .._RADEON_.. instead of
> .._ATI_RADEON_.. as radeonfb.c has them and others aren't even defined
> in any way that I can see. Also, there are a few other undefined symbols
> in there. I don't use console much, so I just disabled the driver, but
> I'm sure some people would appreciate if the driver at least
> compiled. :)

I have a fixed version in PPC 2.5 tree
(bk://ppc.bkbits.net/linuxppc-2.5), I'll eventually send it myself to
Linus if Ani (the maintainer) don't do it.

Ben.

