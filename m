Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTIJL0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbTIJL0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:26:09 -0400
Received: from mid-2.inet.it ([213.92.5.19]:18680 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S262719AbTIJL0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:26:07 -0400
Message-ID: <036a01c3778e$ebadc080$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910120729.C14352@devserv.devel.redhat.com> <20030910103752.GC21313@mail.jlokier.co.uk> <20030910124151.C9878@devserv.devel.redhat.com> <02bc01c37789$ebfa9a40$5aaf7450@wssupremo> <3F5F0820.3090003@cyberone.com.au>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 13:30:19 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Luca,
> There was a zero-copy pipe implementation floating around a while ago
> I think. Did you have a look at that? IIRC it had advantages and
> disadvantages over regular pipes in performance.

Sorry, but i subscripted this mailing-list only one day ago.
Advantages and disadvantages depends on what actually you implement
and on how you do that.

I can only say that capabilities are a disadvantage only with very very
short messages
(that is, a few bytes). And this disadvantage is theoretically demonstrable.

But, let's say also that such elementary messages are meaningful only in the
kernel
and for kernel purposes.

User processes are another tail.

Bye,
Luca

