Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130125AbRBGUhE>; Wed, 7 Feb 2001 15:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129945AbRBGUg4>; Wed, 7 Feb 2001 15:36:56 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:41994 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130337AbRBGUgl>;
	Wed, 7 Feb 2001 15:36:41 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102072036.XAA05599@ms2.inr.ac.ru>
Subject: Re: 2.4.1 tcp ack bug ?
To: pochini@denise.shiny.IT (Giuliano Pochini)
Date: Wed, 7 Feb 2001 23:36:27 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A806260.BB77D017@denise.shiny.it> from "Giuliano Pochini" at Feb 7, 1 11:15:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 20:56:26.172532 ppp0 < mc105-v-2.royaume.com.6699 > ppp12.shiny.it.33148: .
> 88073:89533(1460) ack 77 win 8684 (DF)
....
> Ok, it has just received the missing part, so why it does not ack 98313 ?

Apparently, because this segment has not been received.

Look at checksum errros statistics, for example.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
