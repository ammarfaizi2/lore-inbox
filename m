Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTJWPfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTJWPfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:35:09 -0400
Received: from ns.tasking.nl ([195.193.207.2]:29971 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S263605AbTJWPfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:35:04 -0400
Message-ID: <3F97F4E8.4050707@netscape.net>
Date: Thu, 23 Oct 2003 17:34:00 +0200
From: David Zaffiro <davzaffiro_remove_@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021220 Debian/1.2.1-3
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: "Joseph D. Wagner" <theman@josephdwagner.info>
CC: linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
References: <200310221855.15925.theman@josephdwagner.info>
In-Reply-To: <200310221855.15925.theman@josephdwagner.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you select Pentium III, the -march flag is set to i686.
> If you select Pentium 4, the -march flag is set to i686.
> If you select Athlon 4, the -march flag is set to i686.
> If you select Athlon XP, the -march flag is set to i686.

Depends on the compiler version you use...

For gcc-3.x, I'm sure your settings should be:

If you select Athlon 4, the -march flag is set to athlon
If you select Athlon XP, the -march flag is set to athlon


> I don't want to have to hand edit the makefiles just to optimize my kernel.  

The kernel itself has evolved to its current state because people hand-edited it. The feature you request may be added in the future, it will only be added faster if you care enough to do it yourself and send a patch to this list to share it with others...

