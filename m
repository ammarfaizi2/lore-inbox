Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUHORcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUHORcf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUHORcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:32:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5766 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263770AbUHORcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:32:32 -0400
Date: Sun, 15 Aug 2004 19:32:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@fs.tum.de>
cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>,
       wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
In-Reply-To: <20040814204711.GD1387@fs.tum.de>
Message-ID: <Pine.LNX.4.61.0408151928490.12687@scrub.home>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org>
 <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de>
 <20040811201725.GJ26174@fs.tum.de> <20040811214032.GC7207@mars.ravnborg.org>
 <20040812001003.GV26174@fs.tum.de> <Pine.LNX.4.58.0408121056270.20634@scrub.home>
 <20040814204711.GD1387@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 14 Aug 2004, Adrian Bunk wrote:

> > This is less a problem, as here it's clear that you want a boolean result, 
> > but something like "FOO=n" is really a string compare and FOO could be of 
> > any type (that 99% of all symbols are boolean/tristate symbols doesn't 
> > really help).
> 
> Wouldn't it be better to require a string or hex to always be quoted  
> like "somestring"?

What about normal numbers? I don't think requiring quotes everywhere for 
this is a good idea.

bye, Roman
