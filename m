Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285006AbRLMTjL>; Thu, 13 Dec 2001 14:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285042AbRLMTjB>; Thu, 13 Dec 2001 14:39:01 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:49156 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S285006AbRLMTit>;
	Thu, 13 Dec 2001 14:38:49 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112131938.WAA02795@ms2.inr.ac.ru>
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Thu, 13 Dec 2001 22:38:35 +0300 (MSK)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, mika.liljeberg@nokia.com
In-Reply-To: <3C1901BC.C5E7936C@welho.com> from "Mika Liljeberg" at Dec 13, 1 09:30:04 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> have a fairly low RTO. There were no FIN retransmissions, I'm sorry to
> say.

I believe, believe. :-)

It is possible _only_ if rto is at 120 seconds. It is the only case
when retransmissions do not happen and this would be normal behaviour.

For now it is the only hypothesis and it will be clear from /proc/net/tcp,
whether is this right or not.

Alexey
