Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbTLZKqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 05:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbTLZKqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 05:46:25 -0500
Received: from rat-4.inet.it ([213.92.5.94]:12247 "EHLO rat-4.inet.it")
	by vger.kernel.org with ESMTP id S265165AbTLZKqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 05:46:19 -0500
From: Paolo Ornati <ornati@despammed.com>
To: John Gluck <jgluckca@netscape.net>
Subject: Re: question about setup.c
Date: Fri, 26 Dec 2003 11:47:31 +0100
User-Agent: KMail/1.5.2
References: <3FE88CE8.1020109@netscape.net>
In-Reply-To: <3FE88CE8.1020109@netscape.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312261147.31179.ornati@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 December 2003 19:43, John Gluck wrote:
> Hi
>
> I've been poking around the kernel startup code to try and understand
> the sequence of events. I came across something I don't understand and
> which might be redundant.
>
> This is from the 2.6.0 kernel:
>
> In arch/i386/kernel/setup.c the parse_cmdline_early() function, the
> argument "mem=XXX[kKmM]" is parsed.
>
> In arch/sh/kernel/setup.c the parse_cmdline() function also parses
> "mem=XXX[kKmM]"
>
> Could someone please explain this.

This is because they are two different architectures!
If you are compiling for i386 you aren't compiling for any other 
architecture, and vice versa!

IOW: only one subdirectory of "linux/arch" is used for each compilation.

>
> I am not subscribed to this list so a reply directly to me would be
> appreciated.
>
> Thanks and a Merry Christmas to everyone
>
> John
>

BYE

-- 
	Paolo Ornati
	Linux v2.4.23

