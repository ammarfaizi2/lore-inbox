Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSFIMzR>; Sun, 9 Jun 2002 08:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317607AbSFIMzQ>; Sun, 9 Jun 2002 08:55:16 -0400
Received: from adsl-161-92.barak.net.il ([62.90.161.92]:15889 "EHLO
	qlusters.com") by vger.kernel.org with ESMTP id <S317606AbSFIMzP>;
	Sun, 9 Jun 2002 08:55:15 -0400
Subject: Re: Passthrough kernel module?
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206081318430.6927-100000@dlang.diginsite.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 09 Jun 2002 15:55:02 +0300
Message-Id: <1023627303.1400.16.camel@sake>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-06-08 at 23:24, David Lang wrote:
> I am attempting to reverse engineer the interface for a piece of equipment
> and it would be extreamly handy to have a kernel module that I could load
> that I could then point a /dev entry and and have the module echo
> everything that is sent to it (reads/writes/ioctls) to the real device,
> recording the request and response.
> 
> Does such a module exist? Is there a better way to do this that I'm
> missing?

Much better way:

1. Grab the CVS version of syscall-track from
http://syscalltrack.sourceforge.net/ (AFAIK the stable version doesn't
support read/write yet).
2. Define logging rules on read/write/ioctl on the specific device.
3. Enjoy ;-)

Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
Code mangler, senior coffee drinker and VP SIGSEGV
Qlusters ltd.

"A billion flies _can_ be wrong - I'd rather eat lamb chops than shit."
	-- Linus Torvalds on lkml




