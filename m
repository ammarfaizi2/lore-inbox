Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129899AbRBLXy4>; Mon, 12 Feb 2001 18:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRBLXyh>; Mon, 12 Feb 2001 18:54:37 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:7257 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129626AbRBLXy1>; Mon, 12 Feb 2001 18:54:27 -0500
Message-ID: <007201c09567$f9c21470$8501a8c0@gromit>
From: "Michael Rothwell" <rothwell@holly-springs.nc.us>
To: "Ivan Passos" <lists@cyclades.com>,
        "Linux Kernel List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10102121456380.3761-100000@main.cyclades.com>
Subject: Re: LILO and serial speeds over 9600
Date: Mon, 12 Feb 2001 18:52:16 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then HPA may ask: but why do you want to run the serial console at
> 115200?? The answer is simple: because we ...

... don't want to drag out debugging the kernel on a 38400 connection.
Because printks are our only debugging option ("thanks", Linus), and a slow
serial port block and can change the timing of when code runs, I need the
serial port to run as fast as possible. It would be keen to be able to use
an ethernet debugging console rather than (or in addition to) serial,
because it would be even faster, and if I'm debugging (for instance) a
serial driver, I won't have to use the system I'm debugging to debug the
system I'm debugging.

Of course, a supported kernel debugger would make a nice addition to faster
console output, but I won't hold my breath waiting for Linux to acquire what
pretty much every other operating system already has.

-M

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
