Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbTDOTNj (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbTDOTNj 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:13:39 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:39430 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264034AbTDOTNh (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 15:13:37 -0400
Date: Tue, 15 Apr 2003 20:25:25 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: [FBDEV BK] Updates and fixes.
In-Reply-To: <1050310411.5574.44.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0304152022550.8236-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)
> 
> This is a r128 based chip, which lacks some of the proper support for
> LCD stuff (especially automatic retreival of the EDID from BIOS) that
> we have in radeonfb. If you feed the driver with a suitable mode, it
> should work

Oh. A Rage 128 chip with a LCD display. Then you are out of luck right 
now.

> I haven't yet checked which codebase is in there for rivafb, I have
> started collecting various patches around & doing my own fixes, I have
> a version here that works on PPC with GeForce2 & 4, though I still
> have problems with accel on the GeForce4. It's a 2.4 code base right
> now, I haven't had time to clean that up and release a patch though.
> 
> If 2.5 still has the old codebase, then GeForce4 isn't properly
> supported yet.

We it sort of is old but yet new. I did port alot of the code from 2.4.X. 
to the latest tree. I haven't ported "thee" latest patches tho.

> Note that if you have a flat panel, then the problem of properly
> retreiving the EDID to get a suitable default mode is also present
> there, unless James added some support for it.

It there but only for PPC platforms. Hopefully with the new fbmon.c code I 
will be able to have this work on ix86 very soon.



