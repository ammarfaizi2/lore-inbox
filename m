Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269752AbRHQGKh>; Fri, 17 Aug 2001 02:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269731AbRHQGK2>; Fri, 17 Aug 2001 02:10:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7810 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269712AbRHQGKL>;
	Fri, 17 Aug 2001 02:10:11 -0400
Date: Thu, 16 Aug 2001 23:07:12 -0700 (PDT)
Message-Id: <20010816.230712.68039149.davem@redhat.com>
To: bcrl@redhat.com
Cc: zippel@linux-m68k.org, aia21@cam.ac.uk, tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108170027070.28617-100000@toomuch.toronto.redhat.com>
In-Reply-To: <20010816.195906.38712979.davem@redhat.com>
	<Pine.LNX.4.33.0108170027070.28617-100000@toomuch.toronto.redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben LaHaise <bcrl@redhat.com>
   Date: Fri, 17 Aug 2001 00:29:58 -0400 (EDT)

   On Thu, 16 Aug 2001, David S. Miller wrote:
   
   > Wrong.  This is legal:
   >
   > int test(unsigned long a, int b)
   > {
   > 	return min(a, b);
   > }
   
   I would hope that it would warn: what if a is the maximum size that an
   array can be and b is a value passed in from userland?  Most definately
   not an expected result.

My example was poor, consider if 'b' was something like '100'
or for some other reason you already know perfectly well
the legal range of 'b' or 'a'.

Later,
David S. Miller
davem@redhat.com
