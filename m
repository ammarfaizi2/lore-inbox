Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbUDEVRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUDEVOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:14:50 -0400
Received: from build.arklinux.oregonstate.edu ([128.193.0.51]:30115 "EHLO
	test.arklinux.org") by vger.kernel.org with ESMTP id S263228AbUDEVOF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:14:05 -0400
Date: Mon, 5 Apr 2004 14:23:42 -0700 (PDT)
From: bero@arklinux.org
X-X-Sender: bero@build.arklinux.oregonstate.edu
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching SIGSEGV with signal() in 2.6
In-Reply-To: <20040405181707.GA21245@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0404051422000.13367@build.arklinux.oregonstate.edu>
References: <Pine.LNX.4.58.0404050824310.13367@build.arklinux.oregonstate.edu>
 <20040405181707.GA21245@mail.shareable.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2004, Jamie Lokier wrote:

> > See http://www.openoffice.org/issues/show_bug.cgi?id=27162
> > 
> > Is this change intentional, or a bug?
> 
> On 2.6.3, x86, SIGSEGV is being caught just fine in my test program,
> with the correct fault address, with or without SA_SIGINFO.

Seems to be triggered only by some segfaults -- a simpler test app than 
the one in the OpenOffice bug report works here too, the OpenOffice one 
crashes.

I'll try to debug it some more when I have some time, but that could take 
a while (busy ATM)

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
