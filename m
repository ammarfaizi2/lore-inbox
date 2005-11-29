Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVK2TAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVK2TAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVK2TAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:00:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932350AbVK2TAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:00:51 -0500
Date: Tue, 29 Nov 2005 12:02:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com, tiwai@suse.de
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
Message-Id: <20051129120212.3e679296.akpm@osdl.org>
In-Reply-To: <438CA2D9.8030304@drzeus.cx>
References: <436B2819.4090909@drzeus.cx>
	<20051129113210.3d95d71f.akpm@osdl.org>
	<438CA2D9.8030304@drzeus.cx>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
> Andrew Morton wrote:
> 
> >Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> >  
> >
> >>Add support for suspending devices connected to the PNP bus. New
> >>callbacks are added for the drivers and the PNP hardware layer is
> >>told to disable the device during the suspend.
> >>    
> >>
> >
> >The ALSA guys have gone off and implemented their own version of this, and
> >it's a bit different.   I'll need to drop this patch now.
> >
> >Please review http://www.zip.com.au/~akpm/linux/patches/stuff/git-alsa.patch, sort
> >things out?
> >  
> >
> 
> That things is huge! Do the ALSA guys perhaps have a patch with just the
> PnP bit in it?
> 

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/perex/alsa-current.git;a=commitdiff;h=5353d906effe648dd20899fe61ecb6982ad93cdd

