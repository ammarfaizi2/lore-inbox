Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267214AbUHOXBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267214AbUHOXBz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267226AbUHOXBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:01:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42119 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267214AbUHOXBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:01:51 -0400
Date: Mon, 16 Aug 2004 01:01:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Arnd Bergmann <arnd@arndb.de>,
       Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com,
       "David S. Miller" <davem@redhat.com>, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, sparclinux@vger.kernel.org,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
In-Reply-To: <Pine.GSO.4.58.0408152136400.9281@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.61.0408160050440.12687@scrub.home>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org>
 <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de>
 <20040811201725.GJ26174@fs.tum.de> <20040811214032.GC7207@mars.ravnborg.org>
 <20040812001003.GV26174@fs.tum.de> <Pine.LNX.4.58.0408121056270.20634@scrub.home>
 <20040814204711.GD1387@fs.tum.de> <Pine.LNX.4.61.0408151928490.12687@scrub.home>
 <Pine.GSO.4.58.0408152136400.9281@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 15 Aug 2004, Geert Uytterhoeven wrote:

> > What about normal numbers? I don't think requiring quotes everywhere for
> > this is a good idea.
> 
> And numbers (both decimal and hex) can easily be distinguished from y, n, and m
> anyway.

I did consider this at some point, but I didn't want to add further 
special cases. Every symbol has a tristate and a string value and so you 
can compare pretty much everything with everything else. Splitting the 
string value further into other types isn't worth the trouble. The problem 
at hand is easy enough to solve by adding a type declaration.

bye, Roman
