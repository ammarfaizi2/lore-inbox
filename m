Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTJ0BKq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 20:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTJ0BKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 20:10:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:51619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263717AbTJ0BKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 20:10:45 -0500
Date: Sun, 26 Oct 2003 17:10:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Burton Windle <bwindle@fint.org>, <linux-kernel@vger.kernel.org>
Subject: Re: fsstress causes memory leak in test6, test8
In-Reply-To: <20031026170241.628069e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0310261705440.3157-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Oct 2003, Andrew Morton wrote:
> 
> Given that it took a year for anyone to notice, it's probably best that
> this not be included for 2.6.0.

I agree, let's see if we ever see this as a real problem. Removing the 
heuristic might be worth it at some point, but let's not do it yet.

		Linus

