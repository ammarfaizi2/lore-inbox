Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270800AbRHSVZE>; Sun, 19 Aug 2001 17:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270799AbRHSVYy>; Sun, 19 Aug 2001 17:24:54 -0400
Received: from [209.202.108.240] ([209.202.108.240]:43791 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S270798AbRHSVYr>; Sun, 19 Aug 2001 17:24:47 -0400
Date: Sun, 19 Aug 2001 17:24:48 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Otto Wyss <otto.wyss@bluewin.ch>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why don't have bits the same rights as humans! (flushing to disk
 waiting  time)
In-Reply-To: <3B802B68.ADA545DB@bluewin.ch>
Message-ID: <Pine.LNX.4.33.0108191723420.4118-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Otto Wyss wrote:

> I recently wrote some small files to the floppy disk and noticed almost nothing
> happened immediately but after a certain time the floppy actually started
> writing. So this action took more than 30 seconds instead just a few. This
> remembered me of the elevator problem in the kernel. To transfer this example
> into real live: A person who wants to take the elevator has to wait 8 hours
> before the elevator even starts. While probably everyone agrees this is
> ridiculous in real live astonishingly nobody complains about it in case of a disk.

I've found that unmounting the floppy disk flushes it immediately. What
happens in your case if you unmount it?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


