Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVBURmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVBURmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVBURmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:42:08 -0500
Received: from mail.aknet.ru ([217.67.122.194]:7943 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262049AbVBURlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:41:53 -0500
Message-ID: <421A1D5E.2040200@aknet.ru>
Date: Mon, 21 Feb 2005 20:41:50 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lockup when accessing serial port (and fix)
References: <4207CFED.8020509@aknet.ru> <1108998210.15518.95.camel@localhost.localdomain> <20050221171228.A2768@flint.arm.linux.org.uk>
In-Reply-To: <20050221171228.A2768@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<><>

<><><>Hello.

Russell King wrote:
>> Known bug, just nobody has bothered to fix it. Please send the fix to
>> Linus so it gets into 2.6.11
> The fix was submitted to and accepted by Linus on Feb 8th.  Therefore,
> there's nothing to "bother" with.
I've seen that fix in the latest -mm
patch released shortly after I wrote
the original message, but I can't help
feeling that the other serial drivers
have the same bug. I can see the very
same code in the au1x00_uart.c and other
files too, and it doesn't look like the
fix affected those.
I wasn't dare to ask, but now since also
Alan is bothered - can you please confirm
the other drivers are safe?

<>

<>

<>

