Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271761AbRICSIu>; Mon, 3 Sep 2001 14:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271760AbRICSIk>; Mon, 3 Sep 2001 14:08:40 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:26127 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271638AbRICSI2>;
	Mon, 3 Sep 2001 14:08:28 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109031807.WAA24987@ms2.inr.ac.ru>
Subject: Re: Excessive TCP retransmits over lossless, high latency link
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Mon, 3 Sep 2001 22:07:46 +0400 (MSK DST)
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org
In-Reply-To: <20010903185700.A12529@thefinal.cern.ch> from "Jamie Lokier" at Sep 3, 1 06:57:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Do you mean that you want to see the Linux -> Linux connection, with
> tcpdumps at both ends?

At the end of sender. Receiver side is not so interesting.

Well, if you were able to make it with solaris this would be also interesting.
It would be clear how exactly it miscalculates rtt at least. :-)
But Linux is interesting too. Theoretically it should show better times
even with so short transfer. cwnd stays at 1 and this is very strange.

Alexey
