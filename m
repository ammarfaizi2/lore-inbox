Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVKJP2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVKJP2m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 10:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVKJP2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 10:28:42 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48893 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750845AbVKJP2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 10:28:42 -0500
Date: Thu, 10 Nov 2005 08:28:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
Message-ID: <20051110152841.GD3839@smtp.west.cox.net>
References: <43720DAE.76F0.0078.0@novell.com> <43722AFC.4040709@pobox.com> <1131558785.6540.34.camel@localhost.localdomain> <43735DCA.7060107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43735DCA.7060107@rtr.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 09:48:42AM -0500, Mark Lord wrote:
> Alan Cox wrote:
> >
> >I think it is clearly the case that the design is wrong. The existance
> >of kgdb shows how putting the complex logic remotely on another system
> >is not only a lot cleaner and simpler but can also provide more
> >functionality and higher reliability.
> 
> Unless the target machine is modern (2005+ era) and has no serial ports,
> nor any way to add them other than via the USB stack.

There's always ethernet.  Or, where there is a will, there is a way, as
shown by PowerPC's xmon over firewire.

-- 
Tom Rini
http://gate.crashing.org/~trini/
