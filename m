Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRIKPXS>; Tue, 11 Sep 2001 11:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272464AbRIKPXH>; Tue, 11 Sep 2001 11:23:07 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:63247 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268071AbRIKPWx>;
	Tue, 11 Sep 2001 11:22:53 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109111522.TAA16406@ms2.inr.ac.ru>
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Tue, 11 Sep 2001 19:22:57 +0400 (MSK DST)
Cc: matthias.andree@gmx.de, alan@lxorguk.ukuu.org.uk, wietse@porcupine.org,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <20010910221448.E30149@emma1.emma.line.org> from "Matthias Andree" at Sep 10, 1 10:14:48 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Let's keep this as simple as possible.

A. No way to do the trick with SIOCSIF*.

B. The things does not become simpler when code does something random.
   The things become simpler when code checks something explicitly,
   otherwise you have to add comment: "Well, here we do this against
   plain logic, but this does not matter because of this, this and this."

Alexey
