Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262060AbREZW7G>; Sat, 26 May 2001 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbREZW64>; Sat, 26 May 2001 18:58:56 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262164AbREZW6l>;
	Sat, 26 May 2001 18:58:41 -0400
Message-ID: <007f01c0e618$6907db20$44a6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Mariam George" <mariam_reeny@yahoo.com>, <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <20010526124840.261.qmail@web12304.mail.yahoo.com>
Subject: Re: QOS &fair queuing modules- can't load
Date: Sat, 26 May 2001 12:16:46 -0700
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

>    Let me put across my situation. I need to load the
> modules for QOS & Fair Queuing . I have compiled my
> kernel with modular support for these modules. When I
> try to load these modules a series of error messages
> all indicating unresolved symbols are coming. The
> unresolved symbols  are all defined in
> /usr/src/linux/include/net/pkt_sched.h.
> I have checked out /proc/ksyms file and these symbols
> are listed there,

Are you fulfilling all the requirements for modules , means are you include
proper files and defines module's term while compling your modules , just a
guess.

Better do one thing , define something in kernel , export it in
arch/i386/i386_ksyms.c file and check are you able to get that symbols or
not ?

Jaswinder.
--
These are my opinions not 3Di.


