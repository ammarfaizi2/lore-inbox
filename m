Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135193AbRDLPtL>; Thu, 12 Apr 2001 11:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135208AbRDLPtG>; Thu, 12 Apr 2001 11:49:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54544 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135193AbRDLPs0>;
	Thu, 12 Apr 2001 11:48:26 -0400
Date: Thu, 12 Apr 2001 12:48:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Fwd: Re: memory usage - dentry_cacheg
In-Reply-To: <Pine.GSO.4.21.0104121136550.19944-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0104121247370.18260-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Alexander Viro wrote:

> IOW. keeping dcache/icache size low is not a good thing, unless you
> have a memory pressure that requires it. More agressive kupdate _is_
> a good thing, though - possibly kupdate sans flushing buffers, so that
> it would just keep the icache clean and let bdflush do the actual IO.

Very well. Then I'll leave the balancing between eating from the
page cache and eating from the dcache/icache to you. Have fun.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

