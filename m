Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269517AbRHQDRB>; Thu, 16 Aug 2001 23:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269549AbRHQDQu>; Thu, 16 Aug 2001 23:16:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17537 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269517AbRHQDQj>;
	Thu, 16 Aug 2001 23:16:39 -0400
Date: Thu, 16 Aug 2001 20:13:42 -0700 (PDT)
Message-Id: <20010816.201342.99205586.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B7C8AB8.19BF8425@linux-m68k.org>
In-Reply-To: <3B7C8196.10D1C867@linux-m68k.org>
	<20010816.193841.98557608.davem@redhat.com>
	<3B7C8AB8.19BF8425@linux-m68k.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Fri, 17 Aug 2001 05:08:40 +0200
   
   BTW I just looked through the patch and I only found a single cast, so
   there was not much need for such dumb casts. Your patch now forced the
   cast into all of them...

The cast in the new version is not dumb, it's smart.

It's the programmer saying (to both the reader of the
code and the compiler) "I want this comparison to use
type X".  Period.

There is no ambiguity, there are no multiple-evaluation
issues, and no dumb warnings from the compiler.

Later,
David S. Miller
davem@redhat.com
