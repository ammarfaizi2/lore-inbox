Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbTBQSww>; Mon, 17 Feb 2003 13:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267410AbTBQSww>; Mon, 17 Feb 2003 13:52:52 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:60430 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S267396AbTBQSwu>; Mon, 17 Feb 2003 13:52:50 -0500
Date: Tue, 18 Feb 2003 04:02:13 +0900 (JST)
Message-Id: <20030218.040213.117286588.yoshfuji@wide.ad.jp>
To: bgerst@didntduck.org
Cc: jgarzik@pobox.com, tomita@cinet.co.jp, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, hch@infradead.org
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (16/26) NIC
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <3E5124AC.80505@didntduck.org>
References: <20030217141552.GP4799@yuzuki.cinet.co.jp>
	<3E5115BB.6020407@pobox.com>
	<3E5124AC.80505@didntduck.org>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E5124AC.80505@didntduck.org> (at Mon, 17 Feb 2003 13:06:36 -0500), Brian Gerst <bgerst@didntduck.org> says:

> >  > -#ifdef __ISAPNP__   
> >  > +#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
:
> > Perhaps a dumb question, but I wonder if the above ifdef can be 
> > simplified by turning off ISAPNP on PC9800?
> 
> As long as the machine has ISA expansion slots, ISAPNP is possible.  It 
> is a property of the card, not the system.

Some C-bus (this is the name of the bus of the PC-9800 expansion slots) 
cards seems PnP-capable while PC-9800 series have no ISA slots as I remember.  
I don't know if Linux ISAPNP suport work well with them.

--yoshfuji
