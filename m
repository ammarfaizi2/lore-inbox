Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266647AbTGKJvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbTGKJvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:51:18 -0400
Received: from netcore.fi ([193.94.160.1]:28427 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S266647AbTGKJtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:49:20 -0400
Date: Fri, 11 Jul 2003 13:03:54 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: mika.liljeberg@welho.com, <andre@tomt.net>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
In-Reply-To: <20030711.180449.126456521.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.44.0307111301520.27036-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> In article <Pine.LNX.4.44.0307111143470.26262-100000@netcore.fi> (at Fri, 11 Jul 2003 11:46:00 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:
> > > I don't like this
> > > while I would be ok to have configuration option
> > > not to support anycast.
> > 
> > With "not to support anycast" you probably meant "not to support
> > subnet-router anycast address [automatically, in the kernel, as now]" ?  
> > These are entirely different things.
> 
> I meant disabling anycast entirely.

Oh, I'm not advocating that; however, being able to turn off the subnet 
router anycast address might be a plus.

> > (Note that if there's a user-level API for setting anycast addresses, one 
> > could kick the subnet-router anycast address out of the kernel too.  
> > Whether that's desirable is another thing.)
> 
> We have but we cannot; it is refcnt'ed.

I don't understand what you mean.  Refcnt'ed by a userland process, so 
that if you'd want the subnet-router anycast address, the whole time a 
process (like radvd) should be running.. or what?

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings

