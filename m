Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272063AbTHHWpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272066AbTHHWpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:45:23 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15882 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272063AbTHHWpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:45:20 -0400
Date: Fri, 8 Aug 2003 23:45:16 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Adrian Bunk <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Surprising Kconfig depends semantics
In-Reply-To: <Pine.LNX.4.44.0308082052460.24676-100000@serv>
Message-ID: <Pine.LNX.4.44.0308082302130.32203-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >   default INPUT && INPUT_KEYBOARD && SERIO
> > patch (to address the things James said, in any cases it doesn't do any 
> > harm).
> 
> His comment didn't make much sense, INPUT_KEYBOARD is still independent of 
> SERIO.
....
> The easier solution is probably to force SERIO to 'y' as well, as the 
> point of hiding it behind EMBEDDED is to get it compiled into the kernel.

What I mean is shouldn't build serio by default all the time. USB doesn't 
need it as well as some other drivers like the Amiga keyboard driver.
Serio can also be used by more things than I keyboard driver. Maybe I 
misunderstood?

