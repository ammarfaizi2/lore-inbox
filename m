Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSGHVz3>; Mon, 8 Jul 2002 17:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSGHVz2>; Mon, 8 Jul 2002 17:55:28 -0400
Received: from fe5.rdc-kc.rr.com ([24.94.163.52]:39941 "EHLO mail5.wi.rr.com")
	by vger.kernel.org with ESMTP id <S317180AbSGHVz1>;
	Mon, 8 Jul 2002 17:55:27 -0400
Message-ID: <000d01c226ca$cc5ea840$8a981d41@wi.rr.com>
From: "Ted Kaminski" <mouschi@wi.rr.com>
To: <jbradford@dial.pipex.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200207082150.WAA03372@darkstar.example.net>
Subject: Re: ISAPNP SB16 card with IDE interface
Date: Mon, 8 Jul 2002 16:59:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: <jbradford@dial.pipex.com>
> Are you sure that the CD-ROM drive is jumpered correctly, because Windows
may well not complain if
>it is set to 'slave', but alone on the bus.
>

In fact, it was originally set to slave during its years of windows use...
I've moved it over to master (and tried both) after I encountered this
problem.

> Also, maybe I'm just being stupid, but why is it being recognised as ide3?
The numbering starts at 0, so if
>this is your third interface, it should be ide2.  Could you post a
less-trimmed copy of your dmesg output to
>the list, (or just to me, if it'll annoy the list people).

IDE numbers apparently work just like HD numbers... its not order, it "how
its connected."  In this case, that means the ISAPNP driver sees that the
card requests the IRQ/ports associated with ide3.

and this would be the second interface, not third... (nit-picking...) I'd
have to put together a special boot disk to get a full dmesg, however...
We'll see... (I think... Unless boot messages are in /proc someplace, which
I doubt)

Ted Kaminski

