Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSFKJP0>; Tue, 11 Jun 2002 05:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSFKJPZ>; Tue, 11 Jun 2002 05:15:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48067 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316969AbSFKJPX>;
	Tue, 11 Jun 2002 05:15:23 -0400
Date: Tue, 11 Jun 2002 02:10:43 -0700 (PDT)
Message-Id: <20020611.021043.04190747.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17Hheq-0007r7-00@wagner.rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Tue, 11 Jun 2002 19:09:44 +1000

   In message <3D05A9E8.FF0DA223@zip.com.au> you write:
   > and slowdown:
   
   ARGH!  STOP IT!  I realize it's 'leet to be continually worrying about
   possible microoptimizations, but I challenge you to *measure* the
   slowdown between:

Regardless, his space arguments still hold.

I don't like having everyone eat the overhead that hotplugging cpus
seem to entail.

And remember, it's the anal "every microoptimization at all costs"
people that keep the kernel sane and from running out of control bloat
wise.  Yes, I realize it's a pain in the ass because you might have to
use your brain from time to time to reimplement things to make the
cycle counters happy, but such is life.
