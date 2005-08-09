Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVHIHHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVHIHHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVHIHHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:07:00 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:30676 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932404AbVHIHG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:06:59 -0400
Date: Tue, 9 Aug 2005 09:06:43 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset release ABBA deadlock fix
In-Reply-To: <20050808232558.7173fdd7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508090902350.1805@yvahk01.tjqt.qr>
References: <20050808223722.22843.86768.sendpatchset@jackhammer.engr.sgi.com>
 <20050808232558.7173fdd7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> +	(void) call_usermodehelper(argv[0], argv, envp, 0);
>
>ick.  Why the cast?

Because K&R (also the 2nd ed) does it.
Unfortunately, K&R is always recommended as a book, and apparently
many readers therefore get addicted to casts. Hell, you even see
it [unnecessary casts] in today's books.



Jan Engelhardt
-- 
