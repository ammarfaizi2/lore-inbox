Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132572AbRDHRBB>; Sun, 8 Apr 2001 13:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132575AbRDHRAv>; Sun, 8 Apr 2001 13:00:51 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:16146 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132572AbRDHRAm>;
	Sun, 8 Apr 2001 13:00:42 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104081700.VAA15209@ms2.inr.ac.ru>
Subject: Re: new queuing discipline
To: kernel@sanitas.cz (Oldrich Kepka)
Date: Sun, 8 Apr 2001 21:00:25 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001c01c0c00f$7ce070a0$0200a8c0@kulich.cz> from "Oldrich Kepka" at Apr 8, 1 01:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> packet in the queue. No other conditions i found. But i need repeatedly test
> the top packet in the queue.
> 
> How to accomplish it?

Look into sch_tbf.c for example. Hint: timer.

Alexey
