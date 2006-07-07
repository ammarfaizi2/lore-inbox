Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWGGE5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWGGE5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 00:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWGGE5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 00:57:35 -0400
Received: from mail.gmx.de ([213.165.64.21]:47053 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750814AbWGGE5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 00:57:35 -0400
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu, eggert@cs.ucla.edu,
       roland@redhat.com, rlove@rlove.org, mtk-lkml@gmx.net,
       mtk-manpages@gmx.net, drepper@redhat.com, manfred@colorfullife.com
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 07 Jul 2006 06:57:33 +0200
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
In-Reply-To: <Pine.LNX.4.64.0607061217320.3869@g5.osdl.org>
Message-ID: <20060707045733.186790@gmx.net>
MIME-Version: 1.0
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>
 <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>
 <44AD5CB6.7000607@redhat.com> <44AD5E5C.6070703@colorfullife.com>
 <Pine.LNX.4.64.0607061217320.3869@g5.osdl.org>
Subject: Re: Re: Strange Linux behaviour with blocking syscalls and stop
 signals+SIGCONT
To: Linus Torvalds <torvalds@osdl.org>
X-Authenticated: #2864774
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von: Linus Torvalds <torvalds@osdl.org>

> On Thu, 6 Jul 2006, Manfred Spraul wrote:
> > 
> > Is it necessary that the futex syscall ignores SA_RESTART?
> 
> Very possibly. That was definitely the case for "select()" long ago.

Why was this necesary back then?

Cheers,

Michael

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
