Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSFEHiT>; Wed, 5 Jun 2002 03:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSFEHiS>; Wed, 5 Jun 2002 03:38:18 -0400
Received: from mta02bw.bigpond.com ([139.134.6.34]:460 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S313060AbSFEHiQ>; Wed, 5 Jun 2002 03:38:16 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch] i386 "General Options" - begone [take 2]
Date: Wed, 5 Jun 2002 08:05:21 +1000
User-Agent: KMail/1.4.5
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <200206031318.09634.bhards@bigpond.net.au> <20020604140920.B36@toy.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206050805.21360.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002 00:09, Pavel Machek wrote:
> Please don't tell people about sysrq-D, I'm going to kill that. OTOH
> convient way is echo 4 > /proc/acpi/sleep -- that is if you have ACPI
> enabled.
Extract from the patch:
-  You may suspend your machine by either pressing Sysrq-d or with
<snip>
+  require APM. You may suspend your machine by either pressing 
+  Sysrq-d or with 'swsusp' or 'shutdown -z <time>' (patch for 

So it is in the original. When you kill the functionality, update the doco.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
