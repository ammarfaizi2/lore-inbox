Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291776AbSBXXEm>; Sun, 24 Feb 2002 18:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291774AbSBXXEX>; Sun, 24 Feb 2002 18:04:23 -0500
Received: from tapu.f00f.org ([66.60.186.129]:2690 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S291773AbSBXXEP>;
	Sun, 24 Feb 2002 18:04:15 -0500
Date: Sun, 24 Feb 2002 15:04:01 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224230401.GA15280@tapu.f00f.org>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224013038.G10251@altus.drgw.net>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 01:30:38AM -0600, Troy Benjegerdes wrote:

    Ummm, how does this work if I have two PCI ide cards, one on a
    66mhz PCI bus, and one on a 33mhz PCI bus?

The PCI bus speed will be the greatest that all cards on that bus can
support (33Mhz).  To get 66Mhz PCI cards working at 66Mhz, all cards
on that bus must be 66Mhz.


  --cw

