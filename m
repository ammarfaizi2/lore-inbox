Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTJ3T66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 14:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTJ3T66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 14:58:58 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:5069 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S262784AbTJ3T65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 14:58:57 -0500
Date: Fri, 31 Oct 2003 08:46:46 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Cursor problems still in test9
In-reply-to: <20031030090934.GC295@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net
Message-id: <1067543205.4041.17.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20031028094907.GA1319@elf.ucw.cz>
 <Pine.LNX.4.44.0310300436440.28721-100000@phoenix.infradead.org>
 <20031030090934.GC295@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can also see the cursor not getting erased if you try my software
suspend port with the nice display turned on. It works fine on 2.4, but
under 2.6 you get underlines all over the place, even though it tries to
hide the cursor.

Regards,

Nigel

On Thu, 2003-10-30 at 22:09, Pavel Machek wrote:
> Well, we certainly do not want to see artifacts leaved behind cursor,
> which is what 2.6 currently does. (Type something in bash, backspace
> over it).
> 
> Making it behave like it does now with 2.6, but with cursor properly
> deleted after after backspace, it would be okay.
> 
> [It should behave the same way on 2.4 vgacon and fbcon... with
> possible difference that "bright background" might cause characters to
> blink on vgacon. That depends on vga card setting and is not really
> important.]


-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

