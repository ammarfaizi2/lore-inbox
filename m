Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131239AbQLNUR3>; Thu, 14 Dec 2000 15:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbQLNURT>; Thu, 14 Dec 2000 15:17:19 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:27912 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131239AbQLNURK>;
	Thu, 14 Dec 2000 15:17:10 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012141946.WAA03215@ms2.inr.ac.ru>
Subject: Re: linux ipv6 questions.  bugs?
To: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 14 Dec 2000 22:46:26 +0300 (MSK)
Cc: pete@research.NETsol.COM, linux-kernel@vger.kernel.org
In-Reply-To: <200012141937.TAA02604@raistlin.arm.linux.org.uk> from "Russell King" at Dec 14, 0 07:37:37 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> bash-2.04# strace ping6 -I fe80::800:2b95:1d7b fe80::800:2b95:1d7b

ping6 -I eth0 fe80::800:2b95:1d7b

String "fe80::800:2b95:1d7b" does not allow to guess interface.
In fact, it can be address on your other link or even address
of your neighbour on some link.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
