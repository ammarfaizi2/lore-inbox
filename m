Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAAQD1>; Mon, 1 Jan 2001 11:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRAAQDR>; Mon, 1 Jan 2001 11:03:17 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:8722 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S129415AbRAAQDF>;
	Mon, 1 Jan 2001 11:03:05 -0500
Date: Mon, 1 Jan 2001 17:32:31 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: f5ibh <f5ibh@db0bm.ampr.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-prerelease, AX25 problems
In-Reply-To: <200101011509.QAA15904@db0bm.ampr.org>
Message-ID: <Pine.LNX.4.30.0101011720480.688-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2001, f5ibh wrote:
> I've just compiled and tested 2.4.0-prerelease. My AX25 (hamradio) system does
> not work with this new release. There is a timing problem. When a fram is sent
> on the air, the frame is VERY long (switched off by the watchdog of my drsi
> card) and contains no data. On this point of vue, the previous test version was
> right.

Is the "previous test version" you talk about 2.4.0-test13-pre7?  There
weren't any changes since then that could explain this, except maybe:

> Gnu C                  2.95.2

The minimum required gcc for 2.4 is now 2.91.66. However, AFAIK 2.95.5 was
considered suspect at one point.

-- Hans




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
