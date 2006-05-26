Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWEZQbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWEZQbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWEZQbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:31:10 -0400
Received: from smtp12.wanadoo.fr ([193.252.22.20]:54346 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S1751076AbWEZQag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:30:36 -0400
X-ME-UUID: 20060526163034985.F09201C00097@mwinf1203.wanadoo.fr
Date: Fri, 26 May 2006 18:25:23 +0200
To: Mark Lord <liml@rtr.ca>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Jeff Garzik <jgarzik@pobox.com>,
       Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp c pl atform
Message-ID: <20060526162523.GA13104@powerlinux.fr>
References: <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca> <20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca> <20060526114245.GA32330@powerlinux.fr> <44770065.8070907@rtr.ca> <20060526141535.GA7084@powerlinux.fr> <447722FF.9020202@rtr.ca> <20060526160156.GA11778@powerlinux.fr> <44772B10.7040300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44772B10.7040300@rtr.ca>
User-Agent: Mutt/1.5.9i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 12:21:36PM -0400, Mark Lord wrote:
> Sven Luther wrote:
> >On Fri, May 26, 2006 at 11:47:11AM -0400, Mark Lord wrote:
> >
> >>Meanwhile, I just booted 2.6.17-rc5-git1 (latest kernel.org) on my Mac G3
> >>box here, and sata_mv seems to be behaving for me (thus far).
> >
> >Mmm, this is a G3, while i have a G4. The G4 does some I/O reordering, 
> >which
> >we don't have with a G3, so this may be the cause. 
> 
> MMmm.. is your G4 using a 64-bit kernel, or a 32-bit kernel?

Ah, no, the G4 is a 32bit processor.

> The driver is a complete unknown (for me, at least) on 64-bit systems,
> as I don't have one (of any processor type) here yet.

I have an Xserve G5, which is a 64bit powerpc machine, and i could try it in
it. I need to get the fans to a usable level first though, as it sounds like
an airplan, and is sitting right beside my desk.

> >Do you have a mac version of the board, with a forth/OF bios in it ? Or a
> >normal PC card, which is thus uninitialized ? 
> 
> The board claims to be "mac" compatible, so it probably has an OF bios on 
> it, but I have not verified this yet.

Yes, probably. This could mean that the board gets initialized for you, but
not for me.

Friendly,

Sven Luther

