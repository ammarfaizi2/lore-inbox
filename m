Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRASUSh>; Fri, 19 Jan 2001 15:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbRASUS1>; Fri, 19 Jan 2001 15:18:27 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:10001 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131063AbRASUSP>;
	Fri, 19 Jan 2001 15:18:15 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101192018.XAA25263@ms2.inr.ac.ru>
Subject: Re: Is sendfile all that sexy?
To: zippel@fh-brandenburg.DE (Roman Zippel)
Date: Fri, 19 Jan 2001 23:18:00 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10101190951390.23899-100000@zeus.fh-brandenburg.de> from "Roman Zippel" at Jan 19, 1 01:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It's about direct i/o from/to pages,

Yes. Formally, there are no problems to send to tcp directly from io space.


But could someone explain me one thing. Does bus-mastering
from io really work? And if it does, is it enough fast?
At least, looking at my book on pci, I do not understand
how such transfers are able to use bursts. MRM is banned for them...

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
