Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWGISzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWGISzV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 14:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWGISzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 14:55:21 -0400
Received: from mail.gmx.net ([213.165.64.21]:30139 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161055AbWGISzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 14:55:20 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc1-mm1:  /sys/class/net/ethN becoming symlink
	befuddled /sbin/ifup
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <1152469329.9254.15.camel@Homer.TheSimpsons.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <1152469329.9254.15.camel@Homer.TheSimpsons.net>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 21:01:02 +0200
Message-Id: <1152471662.8448.6.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 20:22 +0200, Mike Galbraith wrote:
> Greetings,
> 
> As $subject says, up-to-date SuSE 10.0 /sbin/ifup became confused...
> 
> -[pid  8191] lstat64("/sys/class/net/eth1", {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> -[pid  8191] lstat64("/sys/block/eth1", 0xafec0f9c) = -1 ENOENT (No such file or directory)

Slight correction:  it's /sbin/getcfg that did the above, resulting in
ipup failing.

