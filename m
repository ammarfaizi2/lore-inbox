Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130755AbQLMQMD>; Wed, 13 Dec 2000 11:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131711AbQLMQLx>; Wed, 13 Dec 2000 11:11:53 -0500
Received: from www.wen-online.de ([212.223.88.39]:45842 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130755AbQLMQLe>;
	Wed, 13 Dec 2000 11:11:34 -0500
Date: Wed, 13 Dec 2000 16:40:58 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rainer Mager <rmager@vgkk.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: Signal 11 - the continuing saga
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGOEBICJAA.rmager@vgkk.com>
Message-ID: <Pine.Linu.4.10.10012131601390.1883-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Rainer Mager wrote:

> Mike et al,
> 
> 	I have no idea what IKD is and I don't know what to do with any results I
> might find BUT I'd be happy to do this if it will help. Please pass on the
> info with the instructions. Who should I report the results to?

IKD is a debugging toolkit.  The trap I have set up freezes the kernel
trace buffer at SIGSEGV time.  From there you have to read it backward
looking for problems. (which isn't particularly easy).  I was thinking
you wanted to roll your shirt sleeves up and maybe this would help ;-)  

If you want it, and do a trace, I'b be very interested in the last
couple of schedules to compare to my traces.  It's not something you
can just run and report though.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
