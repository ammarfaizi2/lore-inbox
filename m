Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276751AbRJKTbi>; Thu, 11 Oct 2001 15:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276765AbRJKTba>; Thu, 11 Oct 2001 15:31:30 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:51214 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276751AbRJKTaI>;
	Thu, 11 Oct 2001 15:30:08 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110111930.XAA28404@ms2.inr.ac.ru>
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
To: sim@netnation.COM (Simon Kirby)
Date: Thu, 11 Oct 2001 23:30:25 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011011114736.A13722@netnation.com> from "Simon Kirby" at Oct 11, 1 11:15:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Is there something that changed from 2.2 -> 2.4 with regards to the
> speed of netstat and /proc/net/tcp?

Incredibly high size of hash table, I think.
At least here size is ~1MB. And all this is read each 1K of data read
via /proc/ :-)

Alexey
