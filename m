Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUFRU36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUFRU36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUFRU3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:29:47 -0400
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:59666 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S262370AbUFRU1E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:27:04 -0400
Date: Fri, 18 Jun 2004 22:26:57 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: Hannu Savolainen <hannu@opensound.com>
cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <Pine.LNX.4.58.0406182006060.20336@zeus.compusonic.fi>
Message-ID: <Pine.LNX.4.58.0406182210490.13079@scrub.local>
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk>
 <40D23EBD.50600@opensound.com> <Pine.LNX.4.58.0406180313350.10292@scrub.local>
 <40D2464D.2060202@opensound.com> <Pine.LNX.4.58.0406181205500.13079@scrub.local>
 <Pine.LNX.4.58.0406182006060.20336@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 18 Jun 2004, Hannu Savolainen wrote:

> > To quote from your previous mail:
> >
> > > make -C /lib/modules/`uname -r`/build scripts scripts_basic include/linux/version.h
> >
> > That doesn't really like documented interfaces to me.
> Right. The documented command is "make install". However an undocumented
> detail is that that doesn't work with "virgin" kernel sources (nothing
> compiled yet). The above command seems to be needed to prepare the source
> tree for building the module.

If the kernel is not configured, there is nothing you can do. You cannot 
automatically configure the kernel and hope it matches the running kernel.
Simply use the standard methods to build an external module and any decent 
distribution should make sure these work and AFAICS SuSE did exactly that.

> The actual problem is that there is no standardized way to compile modules
> outside the kernel source tree.

Wrong, there is no automatic way to build an external that takes care of 
all possible problems and there never will be.

> There will be serious problems if
> different distributions need slightly different installation procedure.

No, there will be serious problems if module authors use undocumented
features and demand for them to work forever.

bye, Roman
