Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270183AbRHMNK0>; Mon, 13 Aug 2001 09:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270185AbRHMNKR>; Mon, 13 Aug 2001 09:10:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2185 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270183AbRHMNKA>;
	Mon, 13 Aug 2001 09:10:00 -0400
Date: Mon, 13 Aug 2001 06:10:10 -0700 (PDT)
Message-Id: <20010813.061010.21928346.davem@redhat.com>
To: jlnance@intrex.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still problems with 2.4.8 VM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010813090743.A7418@bessie.localdomain>
In-Reply-To: <20010813090743.A7418@bessie.localdomain>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jlnance@intrex.net
   Date: Mon, 13 Aug 2001 09:07:43 -0400

 ...
       5 root      20   0     0    0     0 SW   96.6  0.0  18:46 kswapd
 ...   
   Let me know if any further information would be helpful.

If you turn on kernel profiling, does __get_swap_page() show up near
the top after a couple of these unresponsive events?

Later,
David S. Miller
davem@redhat.com
