Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265442AbRFVP3v>; Fri, 22 Jun 2001 11:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265443AbRFVP3l>; Fri, 22 Jun 2001 11:29:41 -0400
Received: from [64.7.140.42] ([64.7.140.42]:18377 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S265442AbRFVP3e>;
	Fri, 22 Jun 2001 11:29:34 -0400
Message-ID: <07e401c0fb30$7eedf5a0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "kees" <kees@schoen.nl>, <linux-kernel@vger.kernel.org>,
        "Jonathan Lundell" <jlundell@pobox.com>, <tytso@mit.edu>
In-Reply-To: <Pine.LNX.4.21.0106220846150.11538-100000@schoen3.schoen.nl> <070001c0fb22$69d68460$294b82ce@connecttech.com> <p05100303b759128e0e65@[207.213.214.37]>
Subject: Re: Q serial.c
Date: Fri, 22 Jun 2001 11:32:06 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jonathan Lundell" <jlundell@pobox.com>
> The other CPU servicing the interrupt, was the question. cli()
> doesn't affect that. This could presumably happen if shutdown() gets
> run on a non-interrupt-servicing CPU, or if interrupts are
> dynamically routed (eg round-robin).

Ah. Missed that.

Hm. Does appear to be a problem. Ted?

> Where can I find the 5.05 driver?

http://serial.sourceforge.net  I'm not sure which version is currently
in 2.4.latest, but it should be nearly 5.05.

..Stu


