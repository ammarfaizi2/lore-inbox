Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTJEXSy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 19:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTJEXSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 19:18:54 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:24557 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263890AbTJEXSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 19:18:53 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Justin Hibbits <jrh29@po.cwru.edu>
Subject: Re: regression between 2.4.18 and 2.4.21/22
Date: Mon, 6 Oct 2003 01:22:30 +0200
User-Agent: KMail/1.5.4
References: <7342FA76-F771-11D7-86F4-000A95841F44@po.cwru.edu>
In-Reply-To: <7342FA76-F771-11D7-86F4-000A95841F44@po.cwru.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310060122.30129.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please narrow down kernel version if you want your problem to be cared.

Try 2.4.19, 2.4.20.  There are also intermediate prepatches at
http://www.kernel.org/pub/linux/kernel/v2.4/testing/old/

dmesg output and .config can also be useful.

--bartlomiej

On Sunday 05 of October 2003 22:21, Justin Hibbits wrote:
> Something very strange is going on with my machine.  With 2.4.18, I was
> getting 38MB/s on my main system disk (IBM Deskstar 60gxp), and 35 for
> the other drives (Western Digital).  The IBM drive is on a Promise IDE
> controller (ASUS A7V266-E motherboard), and the others are on a PROMISE
> 2069 UDMA133 controller.  However, with 2.4.21 and 2.4.22, it will not
> set the using_dma flag for my IBM drive, but sets it for the others,
> which now get sustained transfer rates of 46MB/s or greater.  I'm using
> the same options for all 3 kernels (at least, for the ATA/IDE options).
>   Any help would be appreciated, and I'll see if maybe I could do
> something with it when I get time.

