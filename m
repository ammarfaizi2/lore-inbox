Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSH3VKA>; Fri, 30 Aug 2002 17:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSH3VKA>; Fri, 30 Aug 2002 17:10:00 -0400
Received: from mz01.hal9001.net ([80.16.61.154]:3213 "EHLO server.hal9001.net")
	by vger.kernel.org with ESMTP id <S317525AbSH3VJ6>;
	Fri, 30 Aug 2002 17:09:58 -0400
Message-ID: <3D6FDFE6.4936FB3C@hal9001.net>
Date: Fri, 30 Aug 2002 23:13:10 +0200
From: Stefano Biella <sbiella@hal9001.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Dan Egli <dan@shortcircuit.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic: no init found with 2.5.32
References: <Pine.LNX.3.95.1020830161536.13754A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> The driver for /dev/hda2 (IDE driver) may not have been compiled in
> or not otherwise installed. This would make the root file-system
> inaccessible so /sbin/init can't be found.

The driver is compiled in :-) and the kernel detect the disk.
The disk appear to being correctly mounted ro, but the system hang...

