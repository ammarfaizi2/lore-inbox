Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSACNbe>; Thu, 3 Jan 2002 08:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287283AbSACNbZ>; Thu, 3 Jan 2002 08:31:25 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:14598 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287276AbSACNbN>;
	Thu, 3 Jan 2002 08:31:13 -0500
Date: Thu, 3 Jan 2002 11:30:58 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Harald Holzer <harald.holzer@eunet.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
In-Reply-To: <E16LvZ0-0006CX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0201031129410.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Alan Cox wrote:

> > Which function does the reserved memory fulfill ?
> > Is it all for paging ?
>
> A lot of it is the page structs (64bytes per page - which really
> should be nearer the 32 some rival Unix OS's achieve on x86)

The 2.4 kernel has the page struct at 52 bytes in size,
William Lee Irwin and I have brought this down to 36.

Expect to see this integrated into the rmap VM soon ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

