Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266598AbRGEBiv>; Wed, 4 Jul 2001 21:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266599AbRGEBim>; Wed, 4 Jul 2001 21:38:42 -0400
Received: from mailout3-1.nyroc.rr.com ([24.92.226.168]:31599 "EHLO
	mailout3.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S266598AbRGEBib>; Wed, 4 Jul 2001 21:38:31 -0400
Message-ID: <002501c104f4$c40619b0$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "Daniel Phillips" <phillips@bonn-fries.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <fa.e66agbv.hn0u1v@ifi.uio.no>
Subject: Re: VM Requirement Document - v0.0
Date: Wed, 4 Jul 2001 21:49:43 -0400
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

> Getting the user's "interactive" programs loaded back
> in afterwards is a separate, much more difficult problem
> IMHO, but no doubt still has a reasonable solution.

Possibly stupid suggestion... Maybe the interactive/GUI programs should wake
up once in a while and touch a couple of their pages? Go too far with this
and you'll just get in the way of performance, but I don't think it would
hurt to have processes waking up every couple of minutes and touching glibc,
libqt, libgtk, etc so they stay hot in memory... A very slow incremental
"caress" of the address space could eliminate the
"I-just-logged-in-this-morning-and-dammit-everything-has-been-paged-out"
problem.

Regards,
Dan


