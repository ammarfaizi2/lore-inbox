Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTFGRg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 13:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTFGRg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 13:36:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263295AbTFGRg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 13:36:26 -0400
Message-ID: <33435.4.64.196.31.1055008200.squirrel@www.osdl.org>
Date: Sat, 7 Jun 2003 10:50:00 -0700 (PDT)
Subject: Re: Maximum swap space?
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <colin@colina.demon.co.uk>
In-Reply-To: <ltptlqb72n.fsf@colina.demon.co.uk>
References: <ltptlqb72n.fsf@colina.demon.co.uk>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am somewhat confused about how much swap space you can have with a 2.4
> series kernel. If I read the mkswap man page, I get the impression that I
> could have up to 8x2GB of swap space for a total of 16 GB, but reading the
> RedHat reference guide, it says 2GB maximum.
>
> I presume 2.5 kernels have much higher limits?
> --

Hi,

2.5 limits are the same as 2.4.recent AFAIK, but swapfiles in 2.5 work as
well (fast) as swap partitions if I recall Andrew Morton's comments
correctly.

>From http://www.xenotime.net/linux/doc/swap-mini-howto.txt:

3.  Swap space limits

Linux 2.4.10 and later, and Linux 2.5 support any combination of swap
files or swap devices to a maximum number of 32 of them.  Prior to Linux
2.4.10, the limit was any combination of 8 swap files or swap devices.  On
x86 architecture systems, each of these swap areas has a limit of 2 GiB.

~Randy



