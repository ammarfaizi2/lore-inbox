Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275264AbTHGKr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275271AbTHGKr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:47:29 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:27332 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S275264AbTHGKr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:47:28 -0400
Date: Thu, 7 Aug 2003 20:45:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Charles Lepple <clepple@ghz.cc>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: unable to suspend (APM)
Message-Id: <20030807204553.3c5f432e.sfr@canb.auug.org.au>
In-Reply-To: <3F31BDA3.7040700@ghz.cc>
References: <20030806231519.H16116@flint.arm.linux.org.uk>
	<3F31BDA3.7040700@ghz.cc>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Aug 2003 22:46:59 -0400 Charles Lepple <clepple@ghz.cc> wrote:
>
> Also saw your post about the 3c59x cardbus adapter. I can't recall ever 
> being able to suspend the machine with that card inserted (including 
> under 2.4-- I always had to eject the card before suspend or hibernate). 

The IBM Thinkpad documentation mentions this (or used to) you cannot
suspend a Thinkpad (using APM?) while there is a card powered in the
PCMCIA/Cardbus slot.  You could try doing "cardctrl eject" before
suspending - I find that this works for me (Thinkpad T22).

The message "apm: suspend: Unable to enter requested state" is an
indication of an error from the BIOS.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
