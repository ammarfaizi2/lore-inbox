Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUDCJN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 04:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUDCJN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 04:13:29 -0500
Received: from mail.nlogy.com ([195.146.105.145]:24281 "EHLO mail.nlogy.cz")
	by vger.kernel.org with ESMTP id S261667AbUDCJN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 04:13:27 -0500
Message-ID: <005401c4195b$ede2f950$4100a8c0@rigel>
From: "Kamil Srot" <kamil.srot@nlogy.com>
To: "Jeff Garzik" <jgarzik@pobox.com>,
       "Felix von Leitner" <felix-kernel@fefe.de>
Cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
References: <20040309170945.GA2039@codeblau.de> <404DFB4F.1020208@pobox.com>
Subject: Re: tg3 error
Date: Sat, 3 Apr 2004 11:13:28 +0200
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

> Felix von Leitner wrote:
> > A machine at a customer's site (running kernel 2.4.21) has stopped
> > answering over Ethernet today.  The machine itself was still there and
> > the customer could log in at the console.  A reboot fixed the problem.
> >
> > The machine has had these error messages in the syslog about once per
> > hour for about 24 hours:
> >
> > Mar  9 16:17:38 mail2 kernel: tg3: eth0: transmit timed out, resetting
> > Mar  9 16:17:38 mail2 kernel: tg3: tg3_stop_block timed out, ofs=3400
enable_bit=2
> > Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=2400
enable_bit=2
> > Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=1400
enable_bit=2
> > Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=c00
enable_bit=2
>
>
> AFAIK this is fixed in the latest upstream tg3...

I have exactly the same problems in 2.4.25 - the log says exactly the same
as for Felix.
I'm running two identical HP ProLiant servers but have this problem only on
one of them.
It's happening approximately twice a week.

Any ideas?

Thank you,
--
C.


