Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280998AbRKLVSV>; Mon, 12 Nov 2001 16:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281005AbRKLVSM>; Mon, 12 Nov 2001 16:18:12 -0500
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:10502 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S280998AbRKLVSF>;
	Mon, 12 Nov 2001 16:18:05 -0500
Date: Mon, 12 Nov 2001 22:16:28 +0100
From: Frank de Lange <lkml-frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Abysmal interactive performance on 2.4.linus
Message-ID: <20011112221628.A16035@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Jeff Garzik:
>Can you try 2.4.13ac6 (not 7/8), and 2.2.20, and post a comparison?

Well, as the system is partly reiserfs-based, 2.2.20 is a bit difficult. I've
run the -ac series before trying the 'linus' kernels, and noticed similar
performance problems (but not as severe). I don't have any hard numbers yet,
will try to get some if at all possible (it would be like comparing apples to
reiserfs-oranges).

 [ given the nature of the problem - weird delays during file system activity -
   those numbers will be more or less meaningless. This is not a matter of
   'better' performance on a given hardware platform, but one of 'abysmal'
   performance versus 'normal' performance. It doesn't really matter how long
   the observed delays are, the problem lies in the fact that those delays are
   there in the first place... ]

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
