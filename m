Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUJIUn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUJIUn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUJIUlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:41:22 -0400
Received: from [145.85.127.2] ([145.85.127.2]:38786 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S267405AbUJIUkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:40:24 -0400
Message-ID: <59887.217.121.83.210.1097354414.squirrel@217.121.83.210>
In-Reply-To: <200410091315.10988.lkml@lpbproductions.com>
References: <64778.217.121.83.210.1097351837.squirrel@217.121.83.210>
    <200410091315.10988.lkml@lpbproductions.com>
Date: Sat, 9 Oct 2004 22:40:14 +0200 (CEST)
Subject: Re: [Patch 1/5] xbox: add 'CONFIG_X86_XBOX' to kernel configuration
From: "Ed Schouten" <ed@il.fontys.nl>
To: lkml@lpbproductions.com
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matt,

On Sat, October 9, 2004 10:15 pm, Matt Heler said:
> Why can't theese patches be maintained outside the kernel tree , as it is
> now ?
>
> I'm strongly against this because the X-Box is a gaming platform and last
> I heard ( and I could be wrong here ) is that you had to hack your X-Box in
> order to load any other os then the one supplied with it. I just don't see
> a justified reason why theese patches should be included into the kernel.

It is true that you have to make some modifications to your Xbox, for
example: flashing the BIOS with Cromwell (BIOS with a Linux loader).

The main reason why it should be merged (in my opinion) is that a lot of
Linux distro's reject Xbox-Linux because it's not in the mainline
sourcetree (Debian for example, they only want vanilla platforms).

These patches are only 102 lines together, which is a small amount to
support a new platform.

Yours,
-- 
 Ed Schouten <ed@il.fontys.nl>
 Website: http://g-rave.nl/
