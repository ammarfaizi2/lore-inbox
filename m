Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbSJGXna>; Mon, 7 Oct 2002 19:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262724AbSJGXn3>; Mon, 7 Oct 2002 19:43:29 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:17282 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262637AbSJGXmM>;
	Mon, 7 Oct 2002 19:42:12 -0400
Date: Mon, 7 Oct 2002 18:47:43 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Vojtech Pavlik <vojtech@suse.cz>
cc: jbradford@dial.pipex.com, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.X breaks PS/2 mouse
In-Reply-To: <20021007220829.A1773@ucw.cz>
Message-ID: <Pine.LNX.4.44.0210071846570.4381-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Vojtech Pavlik wrote:

> > > Indeed the 0x08 byte indicates the beginning of a packet. The driver
> > > synchronizes on that, and when it's missing, it ignores the packets.
> > > Thus, it ignores all the packets from the trackball.
> > > 
> > > This patch should fix that:
> > 
> > It does.  Cool!
> > 
> > GPM and X work perfectly.
> > 
> > Cheers!
> 
> And yet another case closed. :)

Before I even get to add it to my problem report page :)

