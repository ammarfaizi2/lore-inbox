Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270952AbRHOAHD>; Tue, 14 Aug 2001 20:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270953AbRHOAGx>; Tue, 14 Aug 2001 20:06:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47493 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270952AbRHOAGe>;
	Tue, 14 Aug 2001 20:06:34 -0400
Date: Tue, 14 Aug 2001 17:06:20 -0700 (PDT)
Message-Id: <20010814.170620.52165537.davem@redhat.com>
To: andrea@suse.de
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010815020303.D4304@athlon.random>
In-Reply-To: <E15Wmp0-00056i-00@gondolin.me.apana.org.au>
	<20010814.154233.98555395.davem@redhat.com>
	<20010815020303.D4304@athlon.random>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Wed, 15 Aug 2001 02:03:03 +0200

   but OTOH the feedback I had was just happy with the 2.4 fix (so I didn't
   even checked if the 2.4 fix was fully compliant or not..).

This is why I'm saying there is no practical reason to make
this change.

The current code can actually improve performance, avoiding needlessly
scanning fd==-1 entries.

Later,
David S. Miller
davem@redhat.com
