Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbUBNCIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 21:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUBNCIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 21:08:47 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:63640 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264566AbUBNCIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 21:08:02 -0500
To: Mark <m.devries@nl.tiscali.com>
Cc: Brandon Low <lostlogic@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: About highmem in 2.6
References: <1o6EZ-2zO-27@gated-at.bofh.it> <1o7AZ-3PD-9@gated-at.bofh.it>
	<402A7EC6.7010003@nl.tiscali.com>
	<20040211212858.2ce1a17d.bonganilinux@mweb.co.za>
	<m3isidkkr6.fsf@defiant.pm.waw.pl>
	<Pine.LNX.4.58.0402120945340.1009@fgevxr.nfculk.yna>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 14 Feb 2004 02:54:53 +0100
In-Reply-To: <Pine.LNX.4.58.0402120945340.1009@fgevxr.nfculk.yna> (Mark's
 message of "Thu, 12 Feb 2004 09:52:05 +0100 (CET)")
Message-ID: <m3ad3mh1ci.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 2GB/2GB split doesn't use any Intel hack nor highmem. In fact for
>> 1 GB of RAM I use a little different split which covers the whole RAM
>> and gives more virtual RAM, something like 1.2/2.8 GB.

While there might a patch for it on the net (so one can configure it with
make *config), I just change 0xC0000000 in arch/i386/vmlinux.lds and in
include/asm-i386/page.h (__PAGE_OFFSET) to something like 0xB0000000.
-- 
Krzysztof Halasa, B*FH
