Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbTH3Mfl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 08:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbTH3Mfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 08:35:41 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:27580
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261725AbTH3Mfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 08:35:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Rahul Karnik <rahul@genebrew.com>, Apurva Mehta <apurva@gmx.net>
Subject: Re: [PATCH]O19int
Date: Sat, 30 Aug 2003 22:42:46 +1000
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200308291550.28159.kernel@kolivas.org> <20030829164137.GC1765@home.woodlands> <3F4F908A.5000204@genebrew.com>
In-Reply-To: <3F4F908A.5000204@genebrew.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308302242.46755.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Aug 2003 03:42, Rahul Karnik wrote:
> Somehow I can never reproduce these xmms skips, even in mainline
> kernels. I had them for a few days with older versions of rhythmbox, but
> no longer. So it seems that some of this is definitely system dependent?
> For the record, I have an Athlon XP 2100+ (1700 MHz) and 1G of memory (a
> pretty medium line desktop system), not the multi-cpu multi-gigabyte-RAM
> systems some people around here do.
>
> Are people getting skips on hardware that is faster than this?

People are not getting skips on hardware significantly lower spec than this. 
The most common remaining reason for this is a misconfigured ide driver, and 
dma issues with their hard drives. Sometimes the driver name has changed 
2.4->2.6 and people using their old config dont inherit the correct driver.

Con

