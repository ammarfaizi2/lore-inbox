Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRAPAKB>; Mon, 15 Jan 2001 19:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbRAPAJv>; Mon, 15 Jan 2001 19:09:51 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:28143 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129763AbRAPAJp>; Mon, 15 Jan 2001 19:09:45 -0500
Message-ID: <3A63911A.A034E31B@home.com>
Date: Mon, 15 Jan 2001 19:08:58 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Taylor <et@rocketship.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tcp no-ack bug can-rpt, w/script incl (this bugs 4 u)
In-Reply-To: <5.0.2.1.2.20010115152847.00a8a380@pop.we.mediaone.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been trying to figure out
> why linux tcp is failing to ack
> properly in some situations.

This is exactly the same problem I'm seeing with a Solaris box talking
to my Linux box. It has a similar problem with Linux as well, but does
not manifest as bad against a 2.2 kernel machine. Seems I was chasing
down the wrong path with MSS and MTU strangeness, I tested this with
ethereal as soon as I saw your post.

No help from me, I'm afraid, but I can at least verify that you are not
the only one seeing it.

John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
