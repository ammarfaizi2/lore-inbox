Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270999AbRIASNA>; Sat, 1 Sep 2001 14:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271095AbRIASMr>; Sat, 1 Sep 2001 14:12:47 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:39428 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S270999AbRIASMm>;
	Sat, 1 Sep 2001 14:12:42 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109011812.WAA19822@ms2.inr.ac.ru>
Subject: Re: Excessive TCP retransmits over lossless, high latency link
To: ak@muc.de (Andi Kleen)
Date: Sat, 1 Sep 2001 22:12:46 +0400 (MSK DST)
Cc: lk@tantalophile.demon.co.uk, davem@redhat.com, ak@muc.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010901194141.44617@colin.muc.de> from "Andi Kleen" at Sep 1, 1 07:41:41 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> packet loss and never has a chance to find out about the longer RTT, because
> that only works with new ACKs. 

Karn algo calculates right rtt after log(rtt/3sec) retransmits.
It is not so big number. In this case, it is 1 in fact. The only effect
of irtt setting is avoiding one retransmission.

Alexey
