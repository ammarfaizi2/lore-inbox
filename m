Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbRHKWvc>; Sat, 11 Aug 2001 18:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268898AbRHKWvX>; Sat, 11 Aug 2001 18:51:23 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:35209 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S268897AbRHKWvR>; Sat, 11 Aug 2001 18:51:17 -0400
Message-Id: <200108112251.f7BMpRh26274@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: Paul Buder <paulb@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Large ramdisk crashes 2.4.8
Date: Sat, 11 Aug 2001 18:51:43 -0400
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.33.0108111309170.19041-100000@shell1.aracnet.com>
In-Reply-To: <Pine.LNX.4.33.0108111309170.19041-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that this condition should occur, but is this task something that 
could be done in tmpfs?  Does tmpfs exhibit the same problems?

	-- Brian

On Saturday 11 August 2001 04:10 pm, Paul Buder wrote:
> A large ramdisk will either crash or make useless a
> 2.4.8 kernel.  I did the following.
>
> I cleared out buffered memory by running this till it
> appropiately died.
> perl -e "$x='x' x 10000 while 1"
>
> top then said I was using 7 megs of ram on my 128 meg box.
