Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTAJO6R>; Fri, 10 Jan 2003 09:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTAJO6R>; Fri, 10 Jan 2003 09:58:17 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:8857 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id <S265066AbTAJO6R>;
	Fri, 10 Jan 2003 09:58:17 -0500
Subject: Re: [2.4.20] e1000 as module gives unresolved symbol _mmx_memcpy
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042211643.31612.2.camel@irongate.swansea.linux.org.uk>
References: <1042206299.1694.12.camel@paragon.slim>
	 <1042211643.31612.2.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1042211459.2706.9.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-1) 
Date: 10 Jan 2003 16:10:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I was thinking along the same lines after
discovering that a lot of other modules had the same problem...:-)
After a mrproper everything is working OK now.

But just to get a complete picture, does it mean that

a) a kernel build for a VIA C3 doesn't use MMX, userspace programs can
still use it

or

b) Both kernel and userspace can't use MMX any more

If option b) would be true a lot of people who are using the VIA Eden
platform to view Divx and other multimedia material will be probably be
hurt performance wise. If the MMX implementation on the C3 is any good.

Greetings,

Jurgen

