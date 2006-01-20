Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161253AbWAUEkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbWAUEkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 23:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWAUEkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 23:40:16 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:33223 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1161253AbWAUEkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 23:40:15 -0500
Date: Fri, 20 Jan 2006 18:22:10 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different	approach
In-reply-to: <1137799001.12998.59.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       linuxppc-dev@ozlabs.org, Ben Collins <ben.collins@ubuntu.com>
Message-id: <1137799330.13530.30.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060119174600.GT19398@stusta.de>
 <20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
 <20060120212917.GA14405@suse.de>
 <1137799001.12998.59.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 10:16 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2006-01-20 at 22:29 +0100, Olaf Hering wrote:
> >  On Fri, Jan 20, Adrian Bunk wrote:
> > 
> >  
> > > Can someone from the ppc developers drop me a small note whether 
> > > SND_POWERMAC completely replaces DMASOUND_PMAC?
> > 
> > It doesnt. Some tumbler models work only after one plug/unplug cycle of
> > the headphone. early powerbooks report/handle the mute settings
> > incorrectly. there are likely more bugs.
> 
> Interesting... Ben Collins hacked something to have Toonie work as a
> "default" driver for non supported machine and saw that problem too, I
> think he fixes it, I'll check with him what's up there and if his fix
> applied to tumbler.c as well.

My "fix" was basically the result of converting to the platform
functions. It's hit or miss whether this works with tumbler too.

You can try the Ubuntu kernel packages (they can be unpacked and used on
non Ubuntu systems pretty easily) to see if it works for you. Tumbler
platform function conversion isn't even tested, so I'd be happy to hear
any feedback.

-- 
Ben Collins
Kernel Developer - Ubuntu Linux

