Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWE2Rcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWE2Rcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 13:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWE2Rcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 13:32:52 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:39908 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750952AbWE2Rcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 13:32:52 -0400
Message-ID: <031301c68345$db9dece0$1800a8c0@dcccs>
From: =?ISO-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: <Valdis.Kletnieks@vt.edu>
Cc: <linux-kernel@vger.kernel.org>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>            <Pine.LNX.4.61.0605291105550.21358@chaos.analogic.com> <200605291535.k4TFZ0VP003544@turing-police.cc.vt.edu>
Subject: Re: How to send a break?
Date: Mon, 29 May 2006 19:32:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: <Valdis.Kletnieks@vt.edu>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Haar János" <djani22@netcenter.hu>; <linux-kernel@vger.kernel.org>
Sent: Monday, May 29, 2006 5:35 PM
Subject: Re: How to send a break?

On Mon, 29 May 2006 11:08:15 EDT, "linux-os (Dick Johnson)" said:
>
> On Sat, 27 May 2006, [iso-8859-2] Haar János wrote:
>
> > Hello, list,
> >
> > I wish to know, how to send a "BREAK" to trigger the sysreq functions on
the
> > serial line, using echo.
> >
> > I mean like this:
> >
> > #!/bin/bash
> > echo "?BREAK?" >/dev/ttyS0
> > sleep 2
> > echo "m" >/dev/ttyS0
> >
> > Thanks,
> > Janos
> >
>
> Can't you use /proc/sysrq-trigger?

> That can be tricky if the other end of /dev/ttyS0 is plugged into a
debugging
> serial port on an embedded system where you don't have easy access to a
shell.

> Or for that matter, if you're trying to talk to the serial port on a
non-embedded
> system, which is too far into OOM thrashing for you to be able to get a
> usable shell prompt.....

This is for debugging an frozen X86_64 system! :-)

Thanks,
Janos

