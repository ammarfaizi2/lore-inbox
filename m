Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDBx0>; Fri, 3 Nov 2000 20:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKDBxQ>; Fri, 3 Nov 2000 20:53:16 -0500
Received: from ha2.rdc2.mi.home.com ([24.2.68.69]:36000 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129033AbQKDBxF>; Fri, 3 Nov 2000 20:53:05 -0500
Message-ID: <3A037A2B.41D6AAA@didntduck.org>
Date: Fri, 03 Nov 2000 21:53:31 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 boot time check for cpu features
In-Reply-To: <Pine.LNX.4.21.0011040101090.6163-100000@neo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> 
> Brian Gerst wrote...
> >> I believe the MII always has CPUID enabled. It was the older Cyrixes
> >> that did not. DaveJ is the guru..
> > Well, according to comments in bugs.h, some broken BIOSes disable cpuid.
> 
> That bug fix is for the earlier Cyrix 6x86 if I'm not mistaken.
> The MII is a different monster.

According to the docs on VIA's site, the MII's cpuid can still be turned
off, but it is on by default at reset.  I wouldn't trust the BIOS to not
screw it up.

--

					Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
