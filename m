Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266469AbRGTBmZ>; Thu, 19 Jul 2001 21:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266479AbRGTBmP>; Thu, 19 Jul 2001 21:42:15 -0400
Received: from [198.99.130.100] ([198.99.130.100]:37250 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S266469AbRGTBmB>;
	Thu, 19 Jul 2001 21:42:01 -0400
Message-Id: <200107200042.f6K0goP09224@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7pre8aa1 
In-Reply-To: Your message of "Fri, 20 Jul 2001 03:37:49 +0200."
             <20010720033749.J31850@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Jul 2001 20:42:50 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

andrea@suse.de said:
> works fine thanks! Of course I agree with rmk it would be better not
> to disable -fno-common but this is ok for now ;) 

Yeah, it's temporary.  rmk's idea was to use the link script to toss errno.o
out of the final binary.

> (after all we would
> catch any potential important name collision during the compiles of
> the other targets)

Agreed.  -fno-common is definitely good.  The only conflict is errno, but 
when Arjan first started playing with -fno-common, he found a couple of UML
bugs.  

				Jeff

