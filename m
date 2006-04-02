Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWDBUKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWDBUKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 16:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWDBUKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 16:10:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28581 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932412AbWDBUKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 16:10:47 -0400
Date: Sun, 2 Apr 2006 13:10:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Buesch <mb@bu3sch.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Latest linus GIT freezes on my G4
In-Reply-To: <200604021801.42662.mb@bu3sch.de>
Message-ID: <Pine.LNX.4.64.0604021309560.3050@g5.osdl.org>
References: <200604021801.42662.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Apr 2006, Michael Buesch wrote:
> 
> Latest Linus-GIT tree freezes on boot on my
> G4 PowerBook.
> The last kernel messages are:
> 
> GMT delta read from XPRAM: 0 minutes, DST: off
> time_init: decrementer frequency = 18.432000 MHz
> time_init: processor frequency   = 1499.999994 MHz

Hmm. Can you try the current one, which has a powerpc update.

If that still doesn't fix it, doing a "git bisect" to find out where it 
started going south would be very very helpful.

		Linus
