Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVDCPLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVDCPLz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 11:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVDCPLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 11:11:55 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:47112 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261790AbVDCPLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 11:11:53 -0400
Date: Sun, 3 Apr 2005 12:11:48 -0300
To: Andrew Morton <akpm@osdl.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: initramfs linus tree breakage in last day
Message-ID: <20050403151148.GB640@conectiva.com.br>
Mail-Followup-To: acme@ghostprotocols.net,
	Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@gmail.com>,
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
References: <9e473391050401181824d9e50f@mail.gmail.com> <9e47339105040119302e6bb405@mail.gmail.com> <9e47339105040122225b96c774@mail.gmail.com> <20050401224431.6c06ca1e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401224431.6c06ca1e.akpm@osdl.org>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.6i
From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 01, 2005 at 10:44:31PM -0800, Andrew Morton escreveu:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> >
> > This will let me boot again. It is not obvious to me where the problem
> >  is, it may have something to do with netlink or maybe memory
> >  corruption?
> > 
> >  bk export -tpatch -r1.2326,1.2327 >../foo.patch
> >  patch -p1 -R <../foo.patch
> > 
> >  # ChangeSet
> >  #   2005/03/31 21:14:28-08:00 davem@sunset.davemloft.net
> >  #   Merge bk://kernel.bkbits.net/acme/net-2.6
> >  #   into sunset.davemloft.net:/home/davem/src/BK/net-2.6
> >  #
> >  # ChangeSet
> >  #   2005/03/26 20:04:49-03:00 acme@toy.ghostprotocols.net
> >  #   [NET] make all protos partially use sk_prot
> 
> Cute.  I assume you have all the memory debug options enabled?
> 
> You could try disabling net features in .config, see if you can work out
> which one causes it.

Question, what are the config choices for netlink?

- Arnaldo
