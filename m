Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbRF1BKZ>; Wed, 27 Jun 2001 21:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265472AbRF1BKP>; Wed, 27 Jun 2001 21:10:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38804 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265470AbRF1BKH>;
	Wed, 27 Jun 2001 21:10:07 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.33772.562679.992220@pizda.ninka.net>
Date: Wed, 27 Jun 2001 18:10:04 -0700 (PDT)
To: NIIBE Yutaka <gniibe@m17n.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <200106280104.f5S14XA05644@mule.m17n.org>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
	<20010628012349.L1554@redhat.com>
	<200106280041.f5S0fDr05278@mule.m17n.org>
	<15162.32433.598824.599520@pizda.ninka.net>
	<200106280104.f5S14XA05644@mule.m17n.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NIIBE Yutaka writes:
 > Aha, that's the reason why we have __flush_dcache_range() in ide_insw
 > for Sparc64 implementation, isn't it?  I'll follow it for SuperH.

This is precisely correct.

 > I'll close the entry for MM bugzilla, it's not MM bug.

Great.

Later,
David S. Miller
davem@redhat.com


