Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263015AbRE1INx>; Mon, 28 May 2001 04:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263001AbRE1INn>; Mon, 28 May 2001 04:13:43 -0400
Received: from [213.96.224.204] ([213.96.224.204]:6148 "HELO manty.net")
	by vger.kernel.org with SMTP id <S263018AbRE1IN3>;
	Mon, 28 May 2001 04:13:29 -0400
Date: Mon, 28 May 2001 10:13:20 +0200
From: Santiago Garcia Mantinan <manty@udc.es>
To: Alexander Viro <viro@math.psu.edu>
Cc: Santiago Garcia Mantinan <manty@udc.es>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at inode.c:654!
Message-ID: <20010528101320.A853@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0105261404010.413-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lovely... It's one of the long lists and these asserts (lines 650 and 654)
> are exactly what would happen if it was corrupted at some place. OTOH, it
> may be for real - i.e. real inodes in wrong state getting on the list, rather
> than corrupted pointer.

You were right, corrupted pointer.

It was due to general memory corruption caused by RAM problems, sorry, it
happened just as I switched to 2.4.5 and I blamed it, it probably started
failing now, after months without any problem, because of the high
temperatures we are having this days.

Thanks for your help and sorry to have disturbed you all for not making a
memtest before :-(

Regards...
-- 
Manty/BestiaTester -> http://manty.net
