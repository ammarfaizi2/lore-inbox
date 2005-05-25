Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVEYRIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVEYRIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVEYRIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:08:12 -0400
Received: from one.firstfloor.org ([213.235.205.2]:28811 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261493AbVEYRG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:06:57 -0400
To: Hendrik Visage <hvjunk@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: False "lost ticks" on dual-Opteron system (=> timer twice as
 fast)
References: <200505081445.26663.bernd.paysan@gmx.de>
	<d93f04c705052112426ee35154@mail.gmail.com>
	<428F9FA6.1000800@coyotegulch.com>
	<d93f04c70505211500216d8614@mail.gmail.com>
	<4291C38D.1040705@coyotegulch.com>
	<d93f04c7050523160430f34d1d@mail.gmail.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 25 May 2005 19:06:56 +0200
In-Reply-To: <d93f04c7050523160430f34d1d@mail.gmail.com> (Hendrik Visage's
 message of "Tue, 24 May 2005 01:04:46 +0200")
Message-ID: <m1fywbxmj3.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hendrik Visage <hvjunk@gmail.com> writes:

> What I still need to ascertain, is whether the MSI K8N Neo Platinum
> (nForce2 250) *do* have a HPET implementation or not, as my timer.c
> only reports a PIT timer :(

Nvidia never reports HPET in their BIOS, so the kernel cannot use it.
There are rumours it is actually in the hardware though, but it would
need magic code to enable.

-Andi
