Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261263AbTCFXfE>; Thu, 6 Mar 2003 18:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbTCFXfE>; Thu, 6 Mar 2003 18:35:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29125 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261263AbTCFXfC>;
	Thu, 6 Mar 2003 18:35:02 -0500
Date: Thu, 06 Mar 2003 15:27:20 -0800 (PST)
Message-Id: <20030306.152720.11812108.davem@redhat.com>
To: rusty@linux.co.intel.com
Cc: miyazawa@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: Re: Latest bk build error in xfrm.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1046986725.4169.40.camel@vmhack>
References: <1046980043.4170.31.camel@vmhack>
	<1046986725.4169.40.camel@vmhack>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Lynch <rusty@linux.co.intel.com>
   Date: 06 Mar 2003 13:38:44 -0800

   The problem is now the core networking has a dependency on the crypto
   hmac code (CONFIG_CRYOTPO_HMAC) since the ipv4 ipsec code was added to
   include/net/xfrm.h (which is included from all kinds of places.)
   
   The pretty much exhaust my networking/ipsec knowledge so no patch.
   
I'm fixing this.
