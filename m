Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263443AbSJHTxd>; Tue, 8 Oct 2002 15:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263457AbSJHTxd>; Tue, 8 Oct 2002 15:53:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49062 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263443AbSJHTxG>;
	Tue, 8 Oct 2002 15:53:06 -0400
Date: Tue, 08 Oct 2002 12:51:10 -0700 (PDT)
Message-Id: <20021008.125110.83071045.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: jasper@spaans.ds9a.nl, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix IPv6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021008.100853.123683687.yoshfuji@linux-ipv6.org>
References: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com>
	<20021007210343.GA1486@mayo.ds9a.tudelft.nl>
	<20021008.100853.123683687.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Tue, 08 Oct 2002 10:08:53 +0900 (JST)
   
   BTW, I repleced __constant_{hton,ntoh}{l,s}() with {hton,htoh}{l,s}(),
   but I believe I did NOT do it for "case" in my patch...

It is error I introduced into the 2.5.x version of
your patch since I had to make some parts by hand.

Fixed in my tree now.
