Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSEVQB3>; Wed, 22 May 2002 12:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316225AbSEVQB2>; Wed, 22 May 2002 12:01:28 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:19585 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S316217AbSEVQB1>;
	Wed, 22 May 2002 12:01:27 -0400
Date: Wed, 22 May 2002 09:01:36 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Stopping ARP responses from local box
Message-ID: <20020522160136.GA6079@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'lo,

I'm trying to set up some 2.4 boxes to work behind a Crisco local
director in funky ARP mode, which requires disabling ARPs on the boxes. 
Unfortunately, "ifconfig eth0 -arp" turns off ARP use for gateway
resolution, which I'd like to keep if possible.

I notice there is "arptable" support in netfilter now, but I don't see
any instructions on how to use it.  Would this do what I want, or is
there something else?  I'd prefer to not have to patch the kernel.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
