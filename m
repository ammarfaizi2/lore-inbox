Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264612AbSJ3GgT>; Wed, 30 Oct 2002 01:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264613AbSJ3GgT>; Wed, 30 Oct 2002 01:36:19 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:43526 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S264612AbSJ3GgS>; Wed, 30 Oct 2002 01:36:18 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200210300642.AAA32370@mako.theneteffect.com>
Subject: Re: Running linux-2.4.20-rc1 on Dell Dimension 4550
To: orion@colorado-research.com (Orion Poplawski)
Date: Wed, 30 Oct 2002 00:42:40 -0600 (CST)
Cc: linux-kernel@vger.kernel.org, req@earth.colorado-research.com
In-Reply-To: <no.id> from "Orion Poplawski" at Oct 29, 2002 04:53:50 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thought I'd post some information about what I'm seeing running RH7.3 with 
> kernel 2.4.20-rc1 on a brand new Dell Dimension 4550.  Currently there are 
> two problems with the machine:
> 
> - When I swtich to a text console and back to the X screen, the machine locks 
> up (or at least the console does not respond anymore).

you don't say the kernel, X, or hardware, but I've seen that personally
with radeon 7500... that what you have?

> - The sound driver does not load, although it seems to try.

seems to be ich4 audio - you need 0.23/24 driver for this to work -
check with the AC series - OR -

with my _particular_ i845E chipset - commenting out the "break;" immediately
after the line that goes "Primary codec not ready" makes this work fine --
probably your computer will burst into flames if you do the same or
something... this is *NOT* a recommendation.

	M
