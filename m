Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTEaO6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbTEaO6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:58:18 -0400
Received: from zork.zork.net ([64.81.246.102]:913 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264340AbTEaO6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:58:17 -0400
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm3: LVM/device-mapper seems broken
References: <20030531013716.07d90773.akpm@digeo.com>
	<6u4r3bky20.fsf@zork.zork.net>
	<1054390711.13115.1.camel@chtephan.cs.pocnet.net>
	<6uznl3jh25.fsf@zork.zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Christophe Saout <christophe@saout.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Sat, 31 May 2003 16:11:33 +0100
In-Reply-To: <6uznl3jh25.fsf@zork.zork.net> (Sean Neakums's message of "Sat,
 31 May 2003 16:01:54 +0100")
Message-ID: <6uvfvrjgm2.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:

> Christophe Saout <christophe@saout.de> writes:
>
>> You need to recompile libdevmapper against the new kernel headers. The
>> kdev_t size has changed and unfortunately the old ioctl interface
>> exposed this limited one to the userspace.
>
> Aha.
>
> The 64-bit device number patch reverses cleanly, so I think I'll just
> build without it and try again.

Okay, that did it.

