Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269896AbTGKKt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 06:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269897AbTGKKt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 06:49:58 -0400
Received: from netcore.fi ([193.94.160.1]:6412 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S269896AbTGKKty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 06:49:54 -0400
Date: Fri, 11 Jul 2003 14:04:28 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: mika.liljeberg@welho.com, <andre@tomt.net>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
In-Reply-To: <20030711.200357.33143193.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.44.0307111403450.27351-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> In article <Pine.LNX.4.44.0307111358440.27351-100000@netcore.fi> (at Fri, 11 Jul 2003 13:59:14 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:
> 
> > > So, you cannot remove subnet router anycast address from
> > > kernel via this interface; kernel keeps one reference.
> > 
> > .. which is why kernel shouldn't keep *any* reference *at all*!
> 
> No, it is because REQUIRED and UNREMOVABLE anycast address.

Smells like a circular requirement :-)

> I don't think it is good to change this.

That's another issue entirely.

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings

