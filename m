Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129496AbQKFTiQ>; Mon, 6 Nov 2000 14:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbQKFTiG>; Mon, 6 Nov 2000 14:38:06 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:56328 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129496AbQKFThw>;
	Mon, 6 Nov 2000 14:37:52 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011061937.WAA20831@ms2.inr.ac.ru>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a user-land  programmer...
To: drepper@cygnus.com
Date: Mon, 6 Nov 2000 22:37:28 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3snp4apb4.fsf@otr.mynet.cygnus.com> from "Ulrich Drepper" at Nov 6, 0 10:15:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Glibc has to use signals because there *still* is not mechanism in the
> kernel to allow synchronization. 

Could you tell why does it use SA_INTERRUPT on its internal signals?

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
