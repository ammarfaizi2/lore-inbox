Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRAHUQx>; Mon, 8 Jan 2001 15:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRAHUQn>; Mon, 8 Jan 2001 15:16:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11271 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129595AbRAHUQb>; Mon, 8 Jan 2001 15:16:31 -0500
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
To: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw)
Date: Mon, 8 Jan 2001 20:17:53 +0000 (GMT)
Cc: richbaum@acm.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010108205001.S3472@arthur.ubicom.tudelft.nl> from "Erik Mouw" at Jan 08, 2001 08:50:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fijt-0005Fj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -    case FORE200E_STATE_BLANK:
> > +    case FORE200E_STATE_BLANK:;
> 
> Is this really a kernel bug? This is common idiom in C, so gcc
> shouldn't warn about it. If it does, it is a bug in gcc IMHO.

It's not valid in current ISO C. So gcc warns about it


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
