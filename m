Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271651AbRIJThJ>; Mon, 10 Sep 2001 15:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271646AbRIJThA>; Mon, 10 Sep 2001 15:37:00 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:58373 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271645AbRIJTgt>;
	Mon, 10 Sep 2001 15:36:49 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109101936.XAA00707@ms2.inr.ac.ru>
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
To: tao@acc.umu.se, matthias.andree@gmx.de
Date: Mon, 10 Sep 2001 23:36:20 +0400 (MSK DST)
Cc: alan@lxorguk.ukuu.org.uk, wietse@porcupine.org,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <20010910100537.W26627@khan.acc.umu.se> from "David Weinehall" at Sep 10, 1 10:05:37 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> a bad idea after all. Whining about this causing "bloat and maintainance

Listen, let's close this thread. :-)

The patch sent by Matthias is enough small not to speak about some bloat.


And I see no reasons to refuse this: it evidently improves the things
almost without efforts. No matter that this imporvement is not so useful,
as it would happen if I guessed this way from the very beginning.
So that applications will have to worry about compatibility with older
kernels in any case.


(BTW Matthias, while applying it to my tree, I noticed that
it does not check for SIOGGIFNETMASK. It would be better to do this only
when it is meaningful: I see only SIOGGIFNETMASK and SIOGGIFBROADCAST).

Alexey
