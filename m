Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269756AbUJGJCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269756AbUJGJCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUJGJC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:02:29 -0400
Received: from mout0.freenet.de ([194.97.50.131]:41381 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S269756AbUJGJAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:00:52 -0400
To: akpm@osdl.org, marian.eichholz@freenet-ag.de
Subject: Re: Fwd: Re: 2.6.9-rc3 does not like diablo news reader daemon
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1CFU8h-0005Vr-1V@nostromo.freenet-ag.de>
From: Michael Haardt <michael@freenet-ag.de>
Date: Thu, 07 Oct 2004 11:00:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Are the oopses always the same?  Please send some more.

There was only one so far, but I will send more, in case I get any.

> - What types of filesytem are in use?

Ext2fs.

> - Are you using any unusual mount options?

No, just defaults.

> - Are you using any uncommon hardware?

No: 2x P3 1 GHz, a standard platform we use for many services.

> - Does the application do anything unusual such as O_DIRECT I/O?

Dreaderd is not compiled with AIO enabled, but it does use mmap(),
madvise() and SYSV shared memory segments.

> - Are any other machines running the same application and kernel?  If so,
>   are they failing?  If not, are you able to use a different machine with
>   2.6.9-rc3?  That'll help us work out whether it's a hardware or software
>   failure.

I will run the same setup on a different machine of same type, no problem.
In the mean time, I keep an eye on the machine that generated the oops.

Michael
