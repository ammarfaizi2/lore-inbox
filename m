Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272639AbRHaI6Q>; Fri, 31 Aug 2001 04:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272640AbRHaI6G>; Fri, 31 Aug 2001 04:58:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29313 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272639AbRHaI5x>;
	Fri, 31 Aug 2001 04:57:53 -0400
Date: Fri, 31 Aug 2001 01:58:06 -0700 (PDT)
Message-Id: <20010831.015806.28787749.davem@redhat.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Newsgroups: lists.linux.kernel
Subject: Re: [UPDATE] 2.4.10-pre2 PCI64, API changes README
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <slrn9ouep3.4d6.kraxel@bytesex.org>
In-Reply-To: <20010830.161453.130817352.davem@redhat.com>
	<E15cbGc-00027M-00@the-village.bc.nu>
	<slrn9ouep3.4d6.kraxel@bytesex.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerd Knorr <kraxel@bytesex.org>
   Date: 31 Aug 2001 07:22:11 GMT
   
   What addresses are in dev->resource?  Physical?  Bus address?  Are they
   unique?

They are implementation dependent values, they may be anything and
cannot be interpreted generically.

You must make portable interfaces for these kinds of things.

Later,
David S. Miller
davem@redhat.com
