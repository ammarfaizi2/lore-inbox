Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbQKFVTH>; Mon, 6 Nov 2000 16:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130190AbQKFVTB>; Mon, 6 Nov 2000 16:19:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15200 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130247AbQKFVSi>; Mon, 6 Nov 2000 16:18:38 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 6 Nov 2000 21:17:47 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), oxymoron@waste.org (Oliver Xymoron),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <m11ywpezve.fsf@frodo.biederman.org> from "Eric W. Biederman" at Nov 06, 2000 11:09:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13steH-0006cy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would probably be better (in this case) to increment the module count
> when the mixer settings go above 0, and decrement it when the settings 
> go totally to 0.  This prevents an unwanted unload.

Thats about 200 lines of code and also about 50,000 emails complaining people
cannot unload sound stuff.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
