Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUFNDvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUFNDvB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 23:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUFNDvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 23:51:01 -0400
Received: from p213.54.107.129.tisdip.tiscali.de ([213.54.107.129]:39811 "EHLO
	stralsunder-10.homelinux.org") by vger.kernel.org with ESMTP
	id S261793AbUFNDu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 23:50:59 -0400
Date: Mon, 14 Jun 2004 05:51:00 +0200
From: Andreas Schmidt <andy@space.wh1.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Frequent system freezes after kernel bug
Message-ID: <20040614035100.GQ1733@rocket>
References: <20040612183742.GE1733@rocket> <20040612202023.GA22145@taniwha.stupidest.org> <20040612214947.GI1733@rocket> <40CB9B84.4030502@g-house.de> <20040613175134.GO1733@rocket> <40CCD1BD.6090509@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <40CCD1BD.6090509@g-house.de> (from evil@g-house.de on Mon, Jun 14, 2004 at 00:14:21 +0200)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.06.14 00:14, Christian Kujau wrote:
> Andreas Schmidt wrote:

> you said:
> | This box runs under Debian stable; I noticed these particular bugs
> | starting with kernel 2.4.24. Yesterday, I updated from 2.4.25 to
> 
> so 2.4.23 did work? would be strange, since patch-2.4.24.b2 is only
> 2,5KB in size and touches very few things. good for you: if 2.4.23 is
> really working and 2.4.24 is not, you could back out the changes and  
> see
> what it gives.
Hmmm, I guess my posting was a bit ambigious in this regard. I started  
out with 2.4.18, upgraded to 2.4.19, later 2.4.21. As the fcdsl-crashes  
(triggered by disconnection) didn't cease, I googled and found other  
reports of the same bug on kernels 2.4.18 and higher, so I decided to  
give it a try and downgrade to 2.4.17. From there, I went right up to  
2.4.24. At that time I learned of a patch to the module which allowed  
to run it without the problems previously encountered. However, there  
still remained the system freezes from the second bug (buffer.c/ 
transaction.c), so I decided to upgrade to 2.4.25 and, ultimately,  
2.4.26.

Best regards,

Andreas
