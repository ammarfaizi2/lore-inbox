Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVK2T7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVK2T7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVK2T7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:59:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932361AbVK2T7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:59:46 -0500
Date: Tue, 29 Nov 2005 13:01:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
Message-Id: <20051129130104.0b0fd77b.akpm@osdl.org>
In-Reply-To: <438CB0D8.90607@drzeus.cx>
References: <436B2819.4090909@drzeus.cx>
	<20051129113210.3d95d71f.akpm@osdl.org>
	<438CA2D9.8030304@drzeus.cx>
	<20051129120212.3e679296.akpm@osdl.org>
	<438CB0D8.90607@drzeus.cx>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
> >http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/perex/alsa-current.git;a=commitdiff;h=5353d906effe648dd20899fe61ecb6982ad93cdd
> >
> >  
> >
> 
> That patch is a bit dumber than mine. It doesn't do anything but call
> the driver supplied suspend/resume function, i.e. no PnP handling during
> suspend. It does handle cards though, something my patch doesn't do.
> Perhaps a combination of the two is acceptable to the ALSA crowd?

Send an update agaisnt next -mm if you like.  We can feed that in through
the alsa tree too.  It's not really appropriate to be updating the pnp
system via the alsa tree, but as long as it's all in one place, it works.

