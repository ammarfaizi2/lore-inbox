Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTBXXI6>; Mon, 24 Feb 2003 18:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTBXXI6>; Mon, 24 Feb 2003 18:08:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16769
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262449AbTBXXI5>; Mon, 24 Feb 2003 18:08:57 -0500
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Schwab <schwab@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302241429150.13406-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0302241429150.13406-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046132400.2216.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 25 Feb 2003 00:20:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 22:39, Linus Torvalds wrote:
> And yes, gcc could do the work necessary to only give the warning if it 
> actually has reason to believe that the code is wrong. As it is, it gives 
> the warning for code that is good.

gcc gives the warning only when you ask it to annoy you. Seems a good trade off. There
are about 15 bug fixes in 2.4.21-pre4ac4,ac5,ac6 solely from that, all real bugs and some
very non obvious
 
