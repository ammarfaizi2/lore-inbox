Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSHaHgR>; Sat, 31 Aug 2002 03:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSHaHgR>; Sat, 31 Aug 2002 03:36:17 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:20740 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316430AbSHaHgQ>; Sat, 31 Aug 2002 03:36:16 -0400
Date: Sat, 31 Aug 2002 02:23:41 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020831022341.C926@jurassic.park.msu.ru>
References: <20020830035318.A3224@jurassic.park.msu.ru> <Pine.LNX.4.44.0208301009210.2163-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208301009210.2163-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 30, 2002 at 10:12:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 10:12:32AM -0700, Linus Torvalds wrote:
> Your logic is so flawed that it's scary.

Maybe.

> Your logic is "I _can_ do it this way, thus everybody else must do it this
> way". Where the _hell_ is the logic there?

Well, I'm just too lazy and don't want to rewrite that setup-bus stuff
once again. :-)
Seriously, I see some implementation issues with "arbitrary number of
resources" approach. By now I don't know how to deal with them.

Ivan.
