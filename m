Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270269AbRH1U4L>; Tue, 28 Aug 2001 16:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270252AbRH1U4C>; Tue, 28 Aug 2001 16:56:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48266 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270131AbRH1Uz4>;
	Tue, 28 Aug 2001 16:55:56 -0400
Date: Tue, 28 Aug 2001 13:56:04 -0700 (PDT)
Message-Id: <20010828.135604.68039530.davem@redhat.com>
To: torvalds@transmeta.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108281348220.15377-100000@penguin.transmeta.com>
In-Reply-To: <20010828.130110.26275634.davem@redhat.com>
	<Pine.LNX.4.33.0108281348220.15377-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 28 Aug 2001 13:49:40 -0700 (PDT)
   
   There might be an argment for making kswapd less eager, and more of a
   background thing.
   
   Regardless of where it actually spends the CPU time.

Right, but this is not an argument against fixing __get_swap_page's
algorithms to be more reasonable :-)

Later,
David S. Miller
davem@redhat.com
