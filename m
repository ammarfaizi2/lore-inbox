Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290223AbSBXHdj>; Sun, 24 Feb 2002 02:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293295AbSBXHd3>; Sun, 24 Feb 2002 02:33:29 -0500
Received: from altus.drgw.net ([209.234.73.40]:517 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S290223AbSBXHdX>;
	Sun, 24 Feb 2002 02:33:23 -0500
Date: Sun, 24 Feb 2002 01:30:38 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224013038.G10251@altus.drgw.net>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Feb 23, 2002 at 10:01:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin not only had "cleanup" in the subject line, but actually explained
> all the changes, including the timing change. The comments at the top of
> the patch mail said (on that particular change, which seems to have been
> your favourite target), typos and all:
> 
> 	3. Replace the functionally totally equal system_bus_block() and
> 	    ide_system_bus_speed() functions with one simple global
> 	    variable: system_bus_speed. This saves quite a significatn amount of
> 	    code. Unfortunately this is the part, which is makeing this
> 	    patch to appear bigger then it really is...

Ummm, how does this work if I have two PCI ide cards, one on a 66mhz PCI 
bus, and one on a 33mhz PCI bus?

Or am I missing something?

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
