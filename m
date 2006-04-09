Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWDIWKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWDIWKg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 18:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWDIWKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 18:10:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52908 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750944AbWDIWKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 18:10:35 -0400
Date: Mon, 10 Apr 2006 00:10:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/19] kconfig: recenter menuconfig
In-Reply-To: <20060409215520.GD30208@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0604100001220.32445@scrub.home>
References: <Pine.LNX.4.64.0604091726550.23116@scrub.home>
 <20060409212548.GA30208@mars.ravnborg.org> <Pine.LNX.4.64.0604092341130.32445@scrub.home>
 <20060409215520.GD30208@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Apr 2006, Sam Ravnborg wrote:

> > Further there is now a mix of left aligned and centered output, 
> > which is ugly
> So we should fix the rest too instead of reintroducing the old
> behaviour.

Well, I prefer the old behaviour.

> > > We truncate longer prompts and with this we require twice the
> > > width to see full prompt.
> > 
> > If these longer prompts don't fit into a 80 coloumn window, it's a bug.
> 
> Try to add three directories somewhere deep to "Initramfs source file(s)".
> Thats where I have been hit by the limitation today.

This means it wouldn't work in a 80 coloumn window either. In either case 
we should fix the real problem, like putting the value on a separate line.

bye, Roman
