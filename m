Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131448AbRAZXtL>; Fri, 26 Jan 2001 18:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131618AbRAZXsw>; Fri, 26 Jan 2001 18:48:52 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:23449 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131448AbRAZXsr>; Fri, 26 Jan 2001 18:48:47 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200101262347.f0QNlWg32020@devserv.devel.redhat.com>
Subject: Re: Possible Bug:  drivers/sound/maestro.c
To: fd0man@crosswinds.net (Michael B. Trausch)
Date: Fri, 26 Jan 2001 18:47:32 -0500 (EST)
Cc: barryn@pobox.com, georgn@somanetworks.com (Georg Nikodym),
        linux-kernel@vger.kernel.org, alan@redhat.com (Alan Cox),
        zab@redhat.com (Zack Brown)
In-Reply-To: <Pine.LNX.4.21.0101261839420.9646-100000@fd0man.accesstoledo.com> from "Michael B. Trausch" at Jan 26, 2001 06:43:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> way up under Linux, I still have to turn the speakers damn near all the
> way up just to hear it with my baseline on the subwoofer.  That's not my
> concern tho, since I can compensate with the speakers (they have an
> excellent amp on them).
> 

Some AC97 codecs have external amplifier controls and we dont yet handle
those properly for all cards. Thats probably why you need your 2nd level
of amp (the one in the speskers) to compensate
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
