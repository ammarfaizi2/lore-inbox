Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268836AbUJPTtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268836AbUJPTtc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268838AbUJPTlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:41:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22472 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268812AbUJPTjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:39:06 -0400
Date: Sat, 16 Oct 2004 21:37:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4: missing patches for swsusp
Message-ID: <20041016193754.GC2547@openzaurus.ucw.cz>
References: <200410162034.00516.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410162034.00516.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks, Rafael!

> AFAICT, the two attached Pavel's patches are missing from 2.6.9-rc4.  Please 
> consider including them into the final 2.6.9, especially 
> x86-64-do-not-use-memory-in-copy-loop.patch which seems to be necessary to 
> prevent random crashes on AMD64.

Both patches are okay. x86-64 patch really should go in
ASAP; clock update patch is not nearly that urgent.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

