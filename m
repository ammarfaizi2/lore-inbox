Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129870AbQLVSxW>; Fri, 22 Dec 2000 13:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbQLVSxN>; Fri, 22 Dec 2000 13:53:13 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:41220 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129870AbQLVSxF>;
	Fri, 22 Dec 2000 13:53:05 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012221821.VAA23667@ms2.inr.ac.ru>
Subject: Re: No more DoS
To: kernel@pineview.NET (Mike OConnor)
Date: Fri, 22 Dec 2000 21:21:45 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <977453684.3a42c2744fbb7@ppro.pineview.net> from "Mike OConnor" at Dec 22, 0 05:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> http://grc.com/r&d/nomoredos.htm
> 
> With my limited unstanding of TCP and DoS attacks this would seem to be the 
> answer, instead of a work around.

More elaborated version of this "answer" is used in linux for ages
under name of syncookies. The approach, proposed here, is a bit different
technically of syncookies, but adds nothing new in result.
Moreover, it loses such crucial property of syncookies as mss negotiation
(which can be fixed of course).

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
