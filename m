Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLEMmH>; Tue, 5 Dec 2000 07:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbQLEMl6>; Tue, 5 Dec 2000 07:41:58 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:48901 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129228AbQLEMlp>; Tue, 5 Dec 2000 07:41:45 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: Serial Console
Date: 5 Dec 2000 12:11:20 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <90im18$p4p$1@enterprise.cistron.net>
In-Reply-To: <Pine.LNX.4.21.0012051202120.1578-100000@sorbus.navaho>
X-Trace: enterprise.cistron.net 976018280 25753 195.64.65.201 (5 Dec 2000 12:11:20 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0012051202120.1578-100000@sorbus.navaho>,
Steve Hill  <steve@navaho.co.uk> wrote:
>I'm building boxes with the console set to /dev/ttyS0.  However, I can't
>guarantee that there will always be a term plugged into the serial
>port.  If there is no term on the port, eventually the buffer fills and
>any processes that write to the console (i.e. init) block.  Is there some
>option somewhere to stop this happening (i.e. either ignoring the
>flow-control or just allowing the buffer to overflow)?

Offtopic, but anyway ..

Sure, turn flow control off. You'll probably have to configure this
on the getty process that runs on ttyS0

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
