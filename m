Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268685AbTBZI4e>; Wed, 26 Feb 2003 03:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268686AbTBZI4e>; Wed, 26 Feb 2003 03:56:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42884 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268685AbTBZI4d>;
	Wed, 26 Feb 2003 03:56:33 -0500
Date: Wed, 26 Feb 2003 00:47:26 -0800 (PST)
Message-Id: <20030226.004726.22558908.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: hch@infradead.org, yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0302261926450.13739-100000@blackbird.intercode.com.au>
References: <20030225160634.A4525@infradead.org>
	<Pine.LNX.4.44.0302261926450.13739-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Wed, 26 Feb 2003 19:33:18 +1100 (EST)

   On Tue, 25 Feb 2003, Christoph Hellwig wrote:
   
   > Also I really wonder whether we want to add just md5.c to 2.4 or
   > backport the cryptoapi core with md5 as the only algorithm so far..
   
   Any backport of new cryptoapi is likely to be some way off (after 2.6
   stabilizes), so the md5 module submitted for 2.4 is required for the time
   being.
   
This could be accelerated.
