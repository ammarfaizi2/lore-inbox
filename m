Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTLaXK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 18:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbTLaXK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 18:10:59 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:10989 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S265279AbTLaXK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 18:10:58 -0500
Subject: Re: udev and devfs - The final word
From: Rob Love <rml@ximian.com>
To: Tommi Virtanen <tv@tv.debian.net>
Cc: Nathan Conrad <lk@bungled.net>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <3FF3436A.7050503@tv.debian.net>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local>
	 <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur>
	 <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur>
	 <3FF3436A.7050503@tv.debian.net>
Content-Type: text/plain
Message-Id: <1072912256.11003.30.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 31 Dec 2003 18:10:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-31 at 16:45, Tommi Virtanen wrote:

> Let me try to rephrase Nathan's question more explicitly.
> 
> If user policy decides all naming, how does the kernel parse e.g. 
> root=/dev/foo arguments? Or the swap partition to use for swsuspend?

Oh.  That has always been a hack, ala name_to_dev_t().

We will have to continue doing that hack so long as those users are in
the kernel proper (and not early user-space, for example).

	Rob Love


