Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWCUPrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWCUPrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWCUPrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:47:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751787AbWCUPrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:47:55 -0500
Date: Tue, 21 Mar 2006 07:47:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: mchehab@infradead.org
cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
Message-ID: <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>
References: <20060320150819.PS760228000000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Mar 2006, mchehab@infradead.org wrote:
>
> Linus, please pull these from master branch.

No. You have totally destroyed your git tree.

In particular, commit e338b736f1aee59b757130ffdc778538b7db18d6 is crap, 
crap, CRAP.

It's "Merging Linus tree", but it's not a merge at all: you have just 
applied the _patch_ to merge the changes in my tree, but you haven't 
actually told git to do so.

I don't know how/why you did that, but it's totally bogus, and I refuse to 
pull from that tree. That's a 5000+ line diff, affecting about 180 files! 

Now, when I pull from your tree, since the changes are already in mine, 
git is smart and it will all _merge_ fine, and there are no changes to 
those files as far as the end result is concerned. But that's still damn 
bogus.

Have you done things like that before, and I just didn't notice? And why?

			Linus
