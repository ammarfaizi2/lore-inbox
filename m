Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTEOCJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263704AbTEOCJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:09:45 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:60883 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263700AbTEOCJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:09:44 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christopher Hoover <ch@murgatroid.com>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
References: <Pine.LNX.4.44.0305141811310.28093-100000@home.transmeta.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 15 May 2003 11:18:35 +0900
In-Reply-To: <Pine.LNX.4.44.0305141811310.28093-100000@home.transmeta.com>
Message-ID: <buohe7xeyv8.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> Btw, the fact that futexes don't work without CONFIG_MMU is a bug not in
> futexes, but it the MMU-less code. The no-mmu version of "follow_page" is
> just wrong and badly implemented, and there's nothing to say that futexes
> aren't useful without a MMU. 

Ah, this is what I was hoping to hear...

-miles
-- 
`Cars give people wonderful freedom and increase their opportunities.
 But they also destroy the environment, to an extent so drastic that
 they kill all social life' (from _A Pattern Language_)
