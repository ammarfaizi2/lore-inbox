Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280959AbRKZFCd>; Mon, 26 Nov 2001 00:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280982AbRKZFCW>; Mon, 26 Nov 2001 00:02:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11648 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280959AbRKZFCG>;
	Mon, 26 Nov 2001 00:02:06 -0500
Date: Sun, 25 Nov 2001 21:02:04 -0800 (PST)
Message-Id: <20011125.210204.104043236.davem@redhat.com>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-final drivers/net/bonding.c includes user space headers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <9trp1d$ppg$1@cesium.transmeta.com>
In-Reply-To: <18133.1006497103@kao2.melbourne.sgi.com>
	<9trp1d$ppg$1@cesium.transmeta.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "H. Peter Anvin" <hpa@zytor.com>
   Date: 25 Nov 2001 13:49:33 -0800
   
   <limits.h> is one of the compiler-provided headers, i.e. from
   /usr/lib/gcc-lib/*/*/include -- if your kbuild harness don't
   allow those headers to be included, it's broken.

Perhaps, but in this case (the bonding driver) the include was
totally unnecessary.
