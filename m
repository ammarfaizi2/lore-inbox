Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTLCP7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265047AbTLCP7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:59:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:29865 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265030AbTLCP7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:59:12 -0500
Date: Wed, 3 Dec 2003 07:59:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David =?iso-8859-15?q?Mart=EDnez=20Moreno?= <ender@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Errors and later panics in 2.6.0-test11.
In-Reply-To: <200312031417.18462.ender@debian.org>
Message-ID: <Pine.LNX.4.58.0312030757120.5258@home.osdl.org>
References: <200312031417.18462.ender@debian.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, David [iso-8859-15] Martínez Moreno wrote:
>
> 	Hello again. I'm testing 2.6.0-test11 in one of my servers. In about a day or
> so under a web/FTP server load, the kernel starts to spit messages:
>
> Dec  2 22:07:25 ulises kernel: Bad page state at prep_new_page
> [ ... ]
>
> 	This machine is Pentium IV with 512 MB of RAM, IDE & SATA disks, RAID 0 over the
> 2 SATA disks, vanilla 2.6.0-test11, Debian testing, apache2 and proftpd.

Interesting. Another RAID 0 problem report..

Is there any way you can test the same setup _without_ using RAID? We seem
to be narrowing down the current 2.6.x problems to RAID usage, but it
would be good to verify that.

		Linus
