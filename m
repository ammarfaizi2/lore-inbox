Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265507AbRGCAFJ>; Mon, 2 Jul 2001 20:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265515AbRGCAEt>; Mon, 2 Jul 2001 20:04:49 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:1986 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S265507AbRGCAEs>;
	Mon, 2 Jul 2001 20:04:48 -0400
Date: Tue, 3 Jul 2001 09:04:42 +0900 (JST)
Message-Id: <200107030004.f6304gL08049@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: "David S. Miller" <davem@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Cache issues
In-Reply-To: <15168.64008.256248.834586@pizda.ninka.net>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
	<20010628012349.L1554@redhat.com>
	<200106280041.f5S0fDr05278@mule.m17n.org>
	<15162.32433.598824.599520@pizda.ninka.net>
	<200106280104.f5S14XA05644@mule.m17n.org>
	<200106291418.f5TEI0i09541@mule.m17n.org>
	<200107021123.f62BNwj02290@mule.m17n.org>
	<15168.64008.256248.834586@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
 > So these older intefaces may not be arbitrarily removed in 2.4.x
 > 
 > The goal is to eventually remove them, this is true.  But it must
 > be done in 2.5.x at the earliest.

Yes, agreed.

I mean, it's almost ready for port maintainers to migrate new
interface (only two issues remain:
include/linux/highmem.h:memclear_highpage_flush and ptrace), as soon
as 2.5.x starts. 

For the time being, I let SH-4 port have null definitions of
flush_page_to_ram and flush_icache_page, and see how things are going.
-- 
