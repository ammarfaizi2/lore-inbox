Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTAEBVW>; Sat, 4 Jan 2003 20:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbTAEBVW>; Sat, 4 Jan 2003 20:21:22 -0500
Received: from smtp2.home.se ([195.66.35.201]:57626 "EHLO smtp2.home.se")
	by vger.kernel.org with ESMTP id <S262780AbTAEBVV>;
	Sat, 4 Jan 2003 20:21:21 -0500
Message-ID: <003f01c2b459$ef247c70$0219450a@sandos>
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: How does the disk buffer cache work?
Date: Sun, 5 Jan 2003 02:29:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Zahorik wrote:
>
> Earlier I wrote to the list where my SS10 hung on the
partition check
> if a bad disk was installed.
>
> This behavior is new to the 2.4.20 kernel.  I
previously ran 2.2.20 on the
> machine. (the default in a Debian 3.0r0 install)  I
can't vouch for 2.4
> kernels previous to 2.4.20.
>
> I have traced the problem to a hang in the one of the
disk buffer caches.
>
> Can anyone tell me how to correct the behavior so
that I:
>
> 1.  Don't break things for other parts of the kernel
> 2.  The disk cache will return with an error for a
hung disk?
>
> Here's the tail of the console with debugging
printk's inserted:
>
> ...
> [.. the next function call in read_cache_page() is
lock_page(), which we
> hang forever on ..]

This happens to me aswell. 2.5.35(I think) and 2.4.20
is not working, a slackware 2.2 bootdisk is fine though
so something is wrong. The hdd is fine in DOS aswell.

---
John Bäckstrand


