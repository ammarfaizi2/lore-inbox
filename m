Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTIOUnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbTIOUnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:43:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:43950 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbTIOUnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:43:51 -0400
Date: Mon, 15 Sep 2003 13:25:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Monster file_lock_cache entry in /proc/slabinfo
Message-Id: <20030915132514.0bee90bc.akpm@osdl.org>
In-Reply-To: <m3k78923wy.fsf@lugabout.jhcloos.org>
References: <m3k78923wy.fsf@lugabout.jhcloos.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James H. Cloos Jr." <cloos@jhcloos.com> wrote:
>
> My notebook has been slowing down the longer it is up for several
> kernel versions.  Disk i/o seems to be the chokepoint.
> 
> I grabbed slabinfo before today's reboot.  The box had been up for 10
> days -- it starts to become painful after about five or six days.
> 
> The file_lock_cache entry seemed rather engrossed:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm2/broken-out/file-locking-leak-fix.patch
