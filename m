Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbTADCzs>; Fri, 3 Jan 2003 21:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTADCzs>; Fri, 3 Jan 2003 21:55:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27336 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264657AbTADCzr>;
	Fri, 3 Jan 2003 21:55:47 -0500
Date: Fri, 03 Jan 2003 18:56:28 -0800 (PST)
Message-Id: <20030103.185628.46335143.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] move struct flock32 3/8 sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030103172118.59b24934.sfr@canb.auug.org.au>
References: <20030103164106.21e65093.sfr@canb.auug.org.au>
	<20030103172118.59b24934.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen, where are compat_off_t and compat_pid_t defined
on sparc64?  I think your patch depends upon some other set
of changes you've done which haven't been applied yet.

Therefore I've just changes your patch to get the build to pass
properly on sparc64.
