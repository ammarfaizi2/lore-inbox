Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270970AbRHOAXx>; Tue, 14 Aug 2001 20:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270973AbRHOAXq>; Tue, 14 Aug 2001 20:23:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64133 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270970AbRHOAX2>;
	Tue, 14 Aug 2001 20:23:28 -0400
Date: Tue, 14 Aug 2001 17:23:33 -0700 (PDT)
Message-Id: <20010814.172333.91312332.davem@redhat.com>
To: andrea@suse.de
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010815021648.G4304@athlon.random>
In-Reply-To: <20010815020303.D4304@athlon.random>
	<20010814.170620.52165537.davem@redhat.com>
	<20010815021648.G4304@athlon.random>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Wed, 15 Aug 2001 02:16:48 +0200
   
   > The current code can actually improve performance, avoiding needlessly
   > scanning fd==-1 entries.
   
   you assume the entries above max_fds are set to -1, while strictly
   speaking they don't need to.

Right, this was my core misunderstanding, see my most
recent mail.

Later,
David S. Miller
davem@redhat.com
