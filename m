Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRDBXFV>; Mon, 2 Apr 2001 19:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRDBXFL>; Mon, 2 Apr 2001 19:05:11 -0400
Received: from mail6.bigmailbox.com ([209.132.220.37]:31238 "EHLO
	mail6.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S131472AbRDBXFF>; Mon, 2 Apr 2001 19:05:05 -0400
Date: Mon, 2 Apr 2001 16:04:12 -0700
Message-Id: <200104022304.QAA19333@mail6.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [24.5.157.48]
From: "Quim K Holland" <qkholland@my-deja.com>
To: szabi@inf.elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] 2.4.x nice level
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "BS" == BERECZ Szabolcs <szabi@inf.elte.hu> writes:

BS> ... a setiathome running at nice level 19, and a bladeenc at
BS> nice level 0. setiathome uses 14 percent, and bladeenc uses
BS> 84 percent of the processor. I think, setiathome should use
BS> max 2-3 percent.  the 14 percent is way too much for me.
BS> ...
BS> with kernel 2.2.16 it worked for me.
BS> now I use 2.4.2-ac20

Would it the case that bladeenc running on 2.4.2 spends more
time doing I/O?  I am not saying that the userland makes more I/O
requests, but if the same set of I/O requests are taking longer
to complete on 2.4.2, then while bladeenc is waiting for their
completion, it is not so surprising that the other process uses
the otherwise-idle CPU cycles.



------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


