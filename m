Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVIJU0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVIJU0e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVIJU0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:26:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:51658 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932276AbVIJU0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:26:33 -0400
Date: Sat, 10 Sep 2005 22:26:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/12] kbuild: mips use generic asm-offsets.h support
In-Reply-To: <20050910193033.GA31516@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0509102217270.3743@scrub.home>
References: <11263057061465-git-send-email-sam@ravnborg.org>
 <Pine.LNX.4.61.0509101949240.3743@scrub.home> <20050910193033.GA31516@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 10 Sep 2005, Sam Ravnborg wrote:

> > >  Kbuild                          |    9 ++++++++-
> > 
> > What's that file good for?
> 
> kbuild looks for the Kbuild file before it looks for Makefile.
> In a desire to move some of the functionality away form the top-level
> Makefile and in to a kbuild file this is needed.

Why don't you put it into scripts/Makefile...?

> The Kbuild file in the top-level directory will take
> over more and more functionality from the top-level
> Makefile to the extent that I hope to end up with two
> readable files.

If the top-level Makefile gets to big, we can move things into scripts/,
that's really no reason to start using Kbuild, in the end it's still a 
Makefile and I'd prefer to call it like that.

bye, Roman
