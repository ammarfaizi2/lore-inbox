Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRG0TGs>; Fri, 27 Jul 2001 15:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268927AbRG0TGi>; Fri, 27 Jul 2001 15:06:38 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:47377 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268926AbRG0TGb>;
	Fri, 27 Jul 2001 15:06:31 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107271906.XAA24733@ms2.inr.ac.ru>
Subject: Re: Subtleties of the 0.0.0.0 netmask (inet_ifa_match)
To: pflau@us.ibm.com (Allen Lau)
Date: Fri, 27 Jul 2001 23:06:28 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OFA1B2627C.7E519218-ON85256A96.00641020@raleigh.ibm.com > from "Allen Lau" at Jul 27, 1 03:03:29 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Can an IP address be on every subnet (i.e. is 10.1.1.1 prefix 0 on every
> subnet)?

Of course. Why not? This means that 10.1.1.1 is address of this
interface and all the rest of internet is attached to this interface directly.

The thing which you want is 255.255.255.255.

Alexey
