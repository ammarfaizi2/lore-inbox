Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVFHCma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVFHCma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 22:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVFHCma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 22:42:30 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:6845 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262074AbVFHCmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 22:42:20 -0400
Date: Tue, 7 Jun 2005 19:42:14 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Blah Blah <gourke@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: boot
Message-Id: <20050607194214.6b060239.rdunlap@xenotime.net>
In-Reply-To: <d73ab4d00506071902172591ad@mail.gmail.com>
References: <d73ab4d00506071902172591ad@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005 10:02:47 +0800 Blah Blah wrote:

| Hi
| I confused the bootsect.S which's in the betwenn 2.4.* kernel and 2.6.*.
| I mean in 2.4.* , it like "jmp $INITSEG, $go",
| but In 2.6.* like 2.6.11,I can not find where use "INITSEG" in
| the bootsect.S file.
| And i'm greate intersted in the basic things in linux. the boot
| must the first thing.
| So i want i can get a good document which descripe the bootsect.S
| file.and some tips will fine too.

bootsect.S isn't used any longer.  see the final changeset comments
for it here:
http://linux.bkbits.net:8080/linux-2.5/related/arch/i386/boot/bootsect.S?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/boot

| another is where's the latest document for 2.6.* kernel? the faq's only 2.4.*
| If you know about it,please tell me.

LDD3 (Linux Device Drivers, 3rd edition) and the in-kernel 'kerneldoc'
comments are the closest to that and the best chance of staying
updated and current.

LDD3 is available at
http://lwn.net/Kernel/LDD3/
or in tree/paper form at (some) bookstores.

| My kernel is 2.6.11.


---
~Randy
