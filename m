Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268219AbUHXT1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268219AbUHXT1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbUHXT1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:27:38 -0400
Received: from mail.dif.dk ([193.138.115.101]:54983 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268219AbUHXT1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:27:33 -0400
Date: Tue, 24 Aug 2004 21:33:09 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Shouldn't kconfig defaults match recommendations in help text?
In-Reply-To: <20040824182930.GA7260@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0408242129130.2770@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0408232347380.3767@dragon.hygekrogen.localhost>
 <16683.22576.781038.756277@alkaid.it.uu.se>
 <Pine.LNX.4.61.0408241859420.2770@dragon.hygekrogen.localhost>
 <20040824182930.GA7260@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Sam Ravnborg wrote:

> On Tue, Aug 24, 2004 at 07:03:55PM +0200, Jesper Juhl wrote:
> > I'll post such patches in a short while. Sepperate mails, one pr patch 
> > changing one kconfig default pr patch.
> 
> One Kconfig file pr. patch makes more sense.
> 
You are right, I'll do that.

Which brings me to another thing regarding configs and defaults - there 
does not seem to be much relation between the defaults in the various 
Kconfig files and the settings in arch/<foo>/defconfig which puzzles me, 
especially since "make defconfig" seems to use the stuff from 
arch/<foo>/defconfig and not what's specified in Kconfig...
Wouldn't it make sense to update the defconfig's to match the Kconfig's 
when I make these changes?

--
Jesper Juhl

