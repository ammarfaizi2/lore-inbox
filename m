Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTDLEzr (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 00:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbTDLEzr (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 00:55:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20948 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263158AbTDLEzq (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 00:55:46 -0400
Date: Fri, 11 Apr 2003 22:01:23 -0700 (PDT)
Message-Id: <20030411.220123.27903772.davem@redhat.com>
To: akpm@digeo.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix bk-curr boot lockup with !CONFIG_IP_MULTICAST
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030411220417.48e48368.akpm@digeo.com>
References: <20030411220417.48e48368.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Fri, 11 Apr 2003 22:04:17 -0700

   in_device.mc_lock is not initialised.  ip_mc_inc_group() locks up on boot.
   
Applied, thanks Andrew.

Linus I'll push this to you later tonight.
