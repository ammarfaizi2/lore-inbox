Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbREMSfu>; Sun, 13 May 2001 14:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbREMSfk>; Sun, 13 May 2001 14:35:40 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:8454 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262328AbREMSfd>;
	Sun, 13 May 2001 14:35:33 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105131834.WAA28023@ms2.inr.ac.ru>
Subject: Re: skb->truesize > sk->rcvbuf == Dropped packets
To: davem@redhat.COM (David S. Miller)
Date: Sun, 13 May 2001 22:34:47 +0400 (MSK DST)
Cc: mike_phillips@urscorp.com, linux-kernel@vger.kernel.org
In-Reply-To: <15089.61095.23597.82875@pizda.ninka.net> from "David S. Miller" at May 4, 1 04:15:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  > Any suggestions on heuristics for this ? 

Not to set rcvbuf to ridiculously low values. The best variant is not
to touch SO_*BUF options at all.

Alexey
