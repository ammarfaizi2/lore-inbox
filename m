Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSIIFbI>; Mon, 9 Sep 2002 01:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSIIFbI>; Mon, 9 Sep 2002 01:31:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56475 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316491AbSIIFbI>;
	Mon, 9 Sep 2002 01:31:08 -0400
Date: Sun, 08 Sep 2002 22:28:10 -0700 (PDT)
Message-Id: <20020908.222810.60190726.davem@redhat.com>
To: phillips@arcor.de
Cc: imran.badr@cavium.com, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17oGvT-0006mX-00@starship>
References: <E17oGD2-0006lP-00@starship>
	<20020908.220008.79156946.davem@redhat.com>
	<E17oGvT-0006mX-00@starship>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@arcor.de>
   Date: Mon, 9 Sep 2002 07:17:30 +0200

   On Monday 09 September 2002 07:00, David S. Miller wrote:
   > Actually, KSEG0 the most Linux friendly design in the world
   > particularly in 64-bit mode.
   
   That's easy to say until you try and work with it (I assume you have,
   and forgot).  Just try to do a 3G/1G split on it, for example.

Maybe you missed the "64-bit mode" part of what I said. :-)

In 64-bit mode there is no need to do any kind of split.
You just use the KSEG mapping with full cache coherency for
all of physical memory as the PAGE_OFFSET area.

I forget if it was KSEG0 or some other number, but I know it
works.

   
