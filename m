Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbTBREwj>; Mon, 17 Feb 2003 23:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267635AbTBREwj>; Mon, 17 Feb 2003 23:52:39 -0500
Received: from dp.samba.org ([66.70.73.150]:25747 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267630AbTBREwi>;
	Mon, 17 Feb 2003 23:52:38 -0500
To: rusty@rustcorp.com.au
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, cyeoh@samba.org, sfr@canb.auug.org.au,
       anton@samba.org, paulus@samba.org, drepper@redhat.com
In-reply-to: <20030218040149.17A5D2C04B@lists.samba.org> (message from Rusty
	Russell on Tue, 18 Feb 2003 15:01:29 +1100)
Subject: Re: [PATCH] Prevent setting 32 uids/gids in the error range
Reply-To: tridge@samba.org
Message-Id: <20030218050239.540F42C04E@lists.samba.org>
Date: Tue, 18 Feb 2003 05:02:39 +0000 (GMT)
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAICT, glibc (2.3.1) gets this wrong, and interprets 0xffffffff
> return from geteuid() as an error (ie. it's not just an strace bug).
> Tested by Tridge.

In case anyone wants it, a simple test program is at
 http://samba.org/ftp/unpacked/junkcode/getegid.c
