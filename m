Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316023AbSEJPTu>; Fri, 10 May 2002 11:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316025AbSEJPTt>; Fri, 10 May 2002 11:19:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32704 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316023AbSEJPTp>;
	Fri, 10 May 2002 11:19:45 -0400
Date: Fri, 10 May 2002 08:07:25 -0700 (PDT)
Message-Id: <20020510.080725.94585622.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: chen_xiangping@emc.com, linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CDBE34A.8050806@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Fri, 10 May 2002 11:12:10 -0400
   
   Linux TCP implementation will always be more powerful and more flexible 
   than any NIC, too.  I doubt they have netlink and netfilter on NICs, for 
   example :)

It has the same problem as proprietary implementations of the BSD
stack, same bugs and same enhancements done N-times instead of once.

Anyone who thinks that having a different TCP implementation on each
different kind of network card installed on your system is sane, would
you please pass it on brotha so I can smoke some of it too! :-)

On a more serious note, it might be at some level considerable (the
maintainence nightmare et al.) if there was some real life
demonstrable performance gain with current systems.

For example, do a SpecWEB run with TUX both using on-chip-TCP and
without, same networking card.  Show a demonstrable gain from the
on-chip-TCP implementation.  I bet you can't.  If you can make such a
claim using a setup that other people could reproduce themselves by
buying your card and running the test, I'll eat all of my words.
