Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132118AbRCYQ4A>; Sun, 25 Mar 2001 11:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132122AbRCYQzv>; Sun, 25 Mar 2001 11:55:51 -0500
Received: from cable039.201.eneco.bart.nl ([195.38.201.39]:22028 "EHLO
	procyon.wilson.nl") by vger.kernel.org with ESMTP
	id <S132118AbRCYQzd>; Sun, 25 Mar 2001 11:55:33 -0500
From: "Michel Wilson" <michel@procyon14.yi.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Larger dev_t
Date: Sun, 25 Mar 2001 18:54:50 +0200
Message-ID: <NEBBLEJBILPLHPBNEEHIEEPNCAAA.michel@procyon14.yi.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010325081524.E30469@sfgoth.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wichert Akkerman wrote:
> > You are just delaying the problem then, at some point your uptime will
> > be large enough that you have run through all 64bit pids for example.
>
> 64 bits is enough to fork 1 million processes per second for over
> 500,000 years.  I think that's putting the problem off far enough.
>
> -Mitch
> -
Ever thought about how you would kill a process: kill -9 127892752 doesn't
sound very appealing to me.
So you'd also need to implement a mechanism that allows for 'easy' selection
of processes to kill, for example giving every process with the same name
a unique identifier (like httpd_0, httpd_1, httpd_2 and so on).

