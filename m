Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264195AbTH1UGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTH1UGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:06:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:53933 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264195AbTH1UGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:06:12 -0400
Date: Thu, 28 Aug 2003 12:50:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-testX and InnoDB (was: Re: 2.6.0-test2-mm3 and mysql)
Message-Id: <20030828125010.7b45407d.akpm@osdl.org>
In-Reply-To: <200308282015.15580.rathamahata@php4.ru>
References: <1059871132.2302.33.camel@mars.goatskin.org>
	<20030804000514.GY22824@waste.org>
	<200308271952.29331.rathamahata@php4.ru>
	<200308282015.15580.rathamahata@php4.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
>
> And here is another one InnoDB crash I've just got with 2.6.0-test4.

Which filesystem?

What sort of I/O system?

Please grab http://www.zip.com.au/~akpm/linux/patches/stuff/fsx-linux.c

and run

	./fsx-linux foo -s <physmem-in-bytes> foo

on that machine for 12 hours or so.  Where <physmem-in-bytes> is (say)
256000000 on a 256-MB machine.

If the machine has more than a couple of gigabytes you'll need to run
multiple instances, against different files.

Make sure that a decent amount of I/O is happening during the run.

