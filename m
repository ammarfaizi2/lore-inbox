Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272636AbRIPSDw>; Sun, 16 Sep 2001 14:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272650AbRIPSDl>; Sun, 16 Sep 2001 14:03:41 -0400
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:10397 "EHLO
	mailout6-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S272636AbRIPSDX>; Sun, 16 Sep 2001 14:03:23 -0400
Message-ID: <042101c13eda$43888e60$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Jeremy Zawodny" <Jeremy@zawodny.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.i95if5v.74un2p@ifi.uio.no> <fa.gu977tv.1b7u0g9@ifi.uio.no>
Subject: Re: broken VM in 2.4.10-pre9
Date: Sun, 16 Sep 2001 14:06:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed.  I'd be great if there was an option to say "Don't swap out
> memory that was allocated by these programs.  If you run out of disk
> buffers, toss the oldest ones and start re-using them."

Have you tried mlockall(MCL_FUTURE)? It's a sledge-hammer but it will do
what you ask...

Dan

