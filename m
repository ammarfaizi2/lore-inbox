Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269223AbRHRQ2O>; Sat, 18 Aug 2001 12:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270247AbRHRQ2E>; Sat, 18 Aug 2001 12:28:04 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:17420 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269223AbRHRQ16>;
	Sat, 18 Aug 2001 12:27:58 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200108181627.UAA19351@ms2.inr.ac.ru>
Subject: Re: PROBLEM: select() says closed socket readable
To: jay@rgrs.COM
Date: Sat, 18 Aug 2001 20:27:47 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15Xwmb-0007eJ-00@shell2.shore.net> from "Jay Rogers" at Aug 18, 1 07:45:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> For linux 2.4.2, select() indicates socket ready for read on a
> socket that's never been connected. 

Right. It does not block on read, hence it is readable.


>					 This is inconsistent

This is perfectly consistent. Reaction to bugs in applications
is undefined.

Alexey
