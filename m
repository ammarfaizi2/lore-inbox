Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVC0JO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVC0JO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 04:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVC0JO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 04:14:56 -0500
Received: from mail.dif.dk ([193.138.115.101]:59616 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261485AbVC0JOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 04:14:54 -0500
Date: Sun, 27 Mar 2005 11:16:55 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>,
       "H. Peter Anvin" <hpa@zytor.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Squashfs without ./..
In-Reply-To: <20050327040518.GA12072@delft.aura.cs.cmu.edu>
Message-ID: <Pine.LNX.4.62.0503271116010.2388@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
 <20050323174925.GA3272@zero> <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
 <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com> <d1v67l$4dv$1@terminus.zytor.com>
 <3e74c9409b6e383b7b398fe919418d54@mac.com> <424324E4.9000003@zytor.com>
 <Pine.LNX.4.62.0503251444060.2498@dragon.hyggekrogen.localhost>
 <20050327040518.GA12072@delft.aura.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Jan Harkes wrote:

> On Fri, Mar 25, 2005 at 02:59:14PM +0100, Jesper Juhl wrote:
> > On Thu, 24 Mar 2005, H. Peter Anvin wrote:
> > > Note that Linux always accepts . and .. so it's just a matter of making them
> > > appear in readdir.
> > > 
> > I'm working on that, but it's a learning experience for me, so it's going 
> > a bit slow - but I'll get there.
> 
> Check the top of coda_venus_readdir in fs/coda/dir.c.
> 
Very useful info you provide. Thank you.

-- 
Jesper

