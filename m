Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273976AbRISBNX>; Tue, 18 Sep 2001 21:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273978AbRISBND>; Tue, 18 Sep 2001 21:13:03 -0400
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:29172 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S273976AbRISBMy>; Tue, 18 Sep 2001 21:12:54 -0400
Message-ID: <0a0c01c140a8$92b45620$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Pavel Machek" <pavel@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.d1dh3vv.fmmj8f@ifi.uio.no> <fa.e30ljmv.19jambt@ifi.uio.no>
Subject: Re: Forced umount (was lazy umount)
Date: Tue, 18 Sep 2001 21:15:24 -0400
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

> Imagine (common error for me):
>
> cd /cdrom
> kwintv &
> [work]
>
> I now want to umount cdrom. How do I do it? Do you suggest each app
> to have "cd /" menu entry?
> Pavel

No but now that you mention it, it might be a good idea for GUI programs to
chdir("/") by default immediately on startup. (and fork/daemonize so they
don't disappear if you accidentally close the xterms you used to start them)

Regards,
Dan

