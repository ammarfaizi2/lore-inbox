Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbTBUAp7>; Thu, 20 Feb 2003 19:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTBUApj>; Thu, 20 Feb 2003 19:45:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28364 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267270AbTBUAoD>;
	Thu, 20 Feb 2003 19:44:03 -0500
Date: Thu, 20 Feb 2003 16:36:19 -0800 (PST)
Message-Id: <20030220.163619.133744671.davem@redhat.com>
To: maxk@qualcomm.com
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
Subject: Re: ioctl32 consolidation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com>
References: <20030220223119.GA18545@elf.ucw.cz>
	<5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Max Krasnyansky <maxk@qualcomm.com>
   Date: Thu, 20 Feb 2003 14:56:22 -0800
   
   Eventually we'll be able to kill ugly mess like arch/sparc64/kernel/ioctl32.c.
   That stuff really belongs to the actual subsystems that implement those ioctls.

Not really possible with things like SIOCDEVPRIVATE...
Those need special processing and even that is insufficient.
