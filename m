Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271578AbRIFRzr>; Thu, 6 Sep 2001 13:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271592AbRIFRz2>; Thu, 6 Sep 2001 13:55:28 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:26121 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271578AbRIFRz1>;
	Thu, 6 Sep 2001 13:55:27 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109061755.VAA12574@ms2.inr.ac.ru>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
To: saw@saw.sw.COM.SG (Andrey Savochkin)
Date: Thu, 6 Sep 2001 21:55:41 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010906193750.B22187@castle.nmd.msu.ru> from "Andrey Savochkin" at Sep 6, 1 07:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Of course, SIOCGIFCONF isn't even close to provide the list of local
> addresses.

Nobody prohibited for example to load netfilter module, which
will accept _all_ the packets to port 6666 as destined locally. :-)

However, the statement is wrong: SIOCGIFCONF really returns
all the addresses which are local "officially". If MTA
fails to deliver mail to "unofficial" address, it is problem
of adminstrator, which either should not create such addresses
or use proper MTA, which has enough reach set of rules, controlling
delivery, sendmail, for example. 

Alexey
