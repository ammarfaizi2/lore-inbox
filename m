Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271200AbRHOO1j>; Wed, 15 Aug 2001 10:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271218AbRHOO1a>; Wed, 15 Aug 2001 10:27:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46208 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271200AbRHOO1P>;
	Wed, 15 Aug 2001 10:27:15 -0400
Date: Wed, 15 Aug 2001 07:24:19 -0700 (PDT)
Message-Id: <20010815.072419.48797129.davem@redhat.com>
To: andrea@suse.de
Cc: thockin@sun.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010815161318.C7382@athlon.random>
In-Reply-To: <20010815021110.F4304@athlon.random>
	<20010814.171609.75760869.davem@redhat.com>
	<20010815161318.C7382@athlon.random>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Wed, 15 Aug 2001 16:13:18 +0200

   I was backporting the new version to 2.2 and I noticed that by using
   NR_OPEN an luser will actually be able to lock into RAM something of the
   order of the dozen mbytes per process.

He can do this with page tables too :-)

Later,
David S. Miller
davem@redhat.com
