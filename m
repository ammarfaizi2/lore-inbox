Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbTDFWD3 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTDFWD3 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:03:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18832
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263139AbTDFWD1 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 18:03:27 -0400
Subject: Re: PROBLEM: Maestro sound module locks up the computer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fredrik Jagenheim <fredde@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030406193707.GG917@pobox.com>
References: <20030406193707.GG917@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049663795.1600.50.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 22:16:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 20:37, Fredrik Jagenheim wrote:
> 8 seconds; e.g. say the clock is '16:40:10'. After 6 seconds the clock is, not
> surprisingly, '16:40:16'; but after 8 seconds it's '16:40:10' again. I'm not
> sure it's exactly 8 seconds though, as I've only had the chance of verifying
> this once.

That kind of weirdness is useful info

> I've narrowed it down (I think) to the maestro driver as these lockups only
> happen when I play music. It doesn't matter if I use mplayer from console, or
> xmms from X, the lockups still happen. These lockups doesn't happen if I don't
> play music, so...
> 
> This started to happen a couple of months ago.

What did you change at the time it happened - any new kernels etc ?

> More information can be obtained if you ask me. It's very easy to reproduce the
> problem (as it happens several times a day), so I can test various hacks if
> you have any.

Does it occur if you turn off all ACPI and APM power management support
in the kernel and in the BIOS ?

