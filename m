Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLDSra>; Mon, 4 Dec 2000 13:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129371AbQLDSrV>; Mon, 4 Dec 2000 13:47:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25432 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129348AbQLDSrE>; Mon, 4 Dec 2000 13:47:04 -0500
Subject: Re: [PATCH] i810_audio 2.4.0-test11
To: sailer@ife.ee.ethz.ch (Thomas Sailer)
Date: Mon, 4 Dec 2000 18:15:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A2BA005.F85423F6@ife.ee.ethz.ch> from "Thomas Sailer" at Dec 04, 2000 02:45:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14309P-00045b-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anything in between is IMO silly. Killing the format
> conversion drops the advantage of running many existing
> applications but don't bring you much closer to the goal
> of simplicity.

Those applications already have to deal with the fact some devices only
support 48KHz 16bit stereo audio. I run a full desktop environment on such
hardware without problems.

What format is it that causes the problems, the only badly supported key format
right know I know of is 16bit bigendian. That needs some small esd patches.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
