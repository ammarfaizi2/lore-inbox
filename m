Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVLVFHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVLVFHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 00:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVLVFHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 00:07:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36245 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965055AbVLVFHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 00:07:01 -0500
Date: Thu, 22 Dec 2005 05:06:55 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Brad Boyer <flar@allandria.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
Message-ID: <20051222050655.GO27946@ftp.linux.org.uk>
References: <20051215085516.GU27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151832270.1609@scrub.home> <20051215175536.GA27946@ftp.linux.org.uk> <Pine.LNX.4.62.0512151858100.6884@pademelon.sonytel.be> <20051215181405.GB27946@ftp.linux.org.uk> <20051215185829.GC27946@ftp.linux.org.uk> <20051215200521.GA18346@pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215200521.GA18346@pants.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 12:05:21PM -0800, Brad Boyer wrote:
> I would like to stop using adb_request in mac/misc.c as well, but it's not
> as simple as just changing it to use cuda_request and pmu_request. That
> should do it for the cuda and pmu based models, but the egret (Mac IIsi
> and friends) based models get left out by that fix. If noone else looks
> at it before me, I'll check this out after I fix some other stuff related
> to m68k mac support.

OK...  AFAICS, patch I've just posted to l-k and linux-m68k (subject:
[PATCH 04/36] m68k: switch mac/misc.c to direct use of appropriate
cuda/pmu/maciisi requests) should so it.  Do you have any problems with
that variant?
