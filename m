Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVGINYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVGINYe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 09:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVGINYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 09:24:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42170 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261378AbVGINYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 09:24:34 -0400
Date: Sat, 9 Jul 2005 15:24:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Bodo Eggert <7eggert@gmx.de>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Documentation mismatch in Documentation/kbuild/kconfig-language.txt
In-Reply-To: <Pine.LNX.4.58.0507090934510.4231@be1.lrz>
Message-ID: <Pine.LNX.4.61.0507091521500.3743@scrub.home>
References: <Pine.LNX.4.58.0507041639500.24224@be1.lrz> <20050708221756.GM3671@stusta.de>
 <Pine.LNX.4.58.0507090934510.4231@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 9 Jul 2005, Bodo Eggert wrote:

> On Sat, 9 Jul 2005, Adrian Bunk wrote:
> > On Mon, Jul 04, 2005 at 04:59:18PM +0200, Bodo Eggert wrote:
> 
> ...
> > > Therefore I can't use
> > > config SGI_IOC4
> > >     tristate
> > >     prompt "SGI IOC4 Base IO support" if PROMPT_FOR_UNUSED_CORES
> > >     depends on (IA64_GENERIC || IA64_SGI_SN2) && MMTIMER
> > >     default n
> ...
> > > Since the "if" is useless, misleading and redundand with this behaviour, I 
> > > suggest stripping it out.
> > 
> > "if" is valuable in "default y" cases.
> 
> It should be, but either it's really applied to the config instead of the 
> prompt (in which can also be added to the depends on list) or the 
> menuconfig '/' function has bogus output.

It's not bogus but simplified, look at the xconfig debug info for a more 
correct representation of the internal data.

bye, Roman
