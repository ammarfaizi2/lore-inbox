Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVCOQSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVCOQSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVCOQRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:17:30 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:29103 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261378AbVCOQP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:15:58 -0500
Message-ID: <42370A3A.6020206@dgreaves.com>
Date: Tue, 15 Mar 2005 16:15:54 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       greg@kroah.com
Cc: Greg Norris <haphazard@kc.rr.com>, linux-kernel@vger.kernel.org,
       akpm <akpm@osdl.org>
Subject: [BUG] Re: [PATCH] scripts/patch-kernel: use EXTRAVERSION
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org> <411E0A37.5040507@anomalistic.org> <20040814205707.GA11936@yggdrasil.localdomain> <20040818135751.197ce3c9.rddunlap@osdl.org> <20040822204002.GB8639@mars.ravnborg.org>
In-Reply-To: <20040822204002.GB8639@mars.ravnborg.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Old thread (!) but this is the last time I could find patch-kernel updated.

Sam Ravnborg wrote:

>On Wed, Aug 18, 2004 at 01:57:51PM -0700, Randy.Dunlap wrote:
>  
>
>>Update 'scripts/patch-kernel' to support EXTRAVERSION.
>>    
>>
>
>I saw no complains, so applied.
>  
>
FYI

$ ./scripts/patch-kernel . /everything/Downloads/Linux/SOURCES/kernel/
Current kernel version is 2.6.10 (Woozy Numbat)
Applying patch-2.6.11 (gzip)... done.
Applying patch-2.6.11.1 (gzip)... done.
Applying patch-2.6.11.2 (gzip)... done.
Applying patch-2.6.11.3 (gzip)... 1 out of 1 hunk FAILED -- saving 
rejects to file Makefile.rej
Reversed (or previously applied) patch detected! Skipping patch.
3 out of 3 hunks ignored -- saving rejects to file 
drivers/input/serio/i8042-x86ia64io.h.rej
Reversed (or previously applied) patch detected! Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file 
drivers/md/raid6altivec.uc.rej
Reversed (or previously applied) patch detected! Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file fs/eventpoll.c.rej
failed. Clean up yourself.


David
