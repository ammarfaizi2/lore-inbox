Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVKWXcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVKWXcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVKWXcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:32:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:29668 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751319AbVKWXcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:32:21 -0500
Subject: Re: [git pull 09/14] Uinput: add UI_SET_SWBIT ioctl
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dtor_core@ameritech.net
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000511231512n686b8918v65b209863c93cc2a@mail.gmail.com>
References: <20051120063611.269343000.dtor_core@ameritech.net>
	 <20051120064420.389911000.dtor_core@ameritech.net>
	 <1132786887.26560.341.camel@gaston>
	 <d120d5000511231512n686b8918v65b209863c93cc2a@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 10:28:33 +1100
Message-Id: <1132788513.26560.348.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > to userland via read() ... cool, a structure that is not compatible
> > between 32 and 64 bits passed around via a read call. that will be fun
> > to fix.
> >
> 
> It would need the same treatment as evdev got. Entire uinput is not
> 32/64 bit friendly (hostorically). However, it should be used by an
> userspace "driver", not an ordinary program, so we probably shoudl
> just require using native-sized binary with uinput.

Not realistic. Some distros still don't have 64 bits userland ...

Ben.


