Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274034AbRJGOHK>; Sun, 7 Oct 2001 10:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275852AbRJGOHA>; Sun, 7 Oct 2001 10:07:00 -0400
Received: from ns.suse.de ([213.95.15.193]:38669 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S274034AbRJGOGn>;
	Sun, 7 Oct 2001 10:06:43 -0400
Date: Sun, 7 Oct 2001 16:07:11 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Thomas Hood <jdthood@mail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux should not set the "PnP OS" boot flag
In-Reply-To: <1002462656.831.112.camel@thanatos>
Message-ID: <Pine.LNX.4.30.0110071604050.11423-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Oct 2001, Thomas Hood wrote:

> I think you'll understand why I say that it is not handled
> _correctly_ and that the handling must be brought under
> the user's control ... if not via a /proc entry then by
> a build option or boot option.  I invite advice about this.

The final part doesn't need to be in kernel space at all.
(And from my reading of the spec, shouldn't be, as it signifies
the OS completed the final stages of booting successfully)

http://www.codemonkey.org.uk/sbf.c
is some quick code I hacked up when bootflag.c first appeared.
Its not perfect, and I have some outstanding patches that Randy Dunlap
sent to clean up some bits, but I've not got around to merging them.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

