Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUIAAYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUIAAYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269209AbUIAAJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:09:36 -0400
Received: from frog.mt.lv ([159.148.172.197]:24740 "EHLO frog.mt.lv")
	by vger.kernel.org with ESMTP id S269218AbUHaXo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:44:56 -0400
From: Dmitry Golubev <dmitry@mikrotik.com>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH] embedding 2.6 or more findings on kernel size
Date: Wed, 1 Sep 2004 02:41:20 +0300
User-Agent: KMail/1.6.2
References: <200408302307.35052.dmitry@mikrotik.com> <200408311710.01601.dmitry@mikrotik.com> <20040831202707.GQ3466@fs.tum.de>
In-Reply-To: <20040831202707.GQ3466@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409010241.20950.dmitry@mikrotik.com>
X-mikrotik.com-Virus_kerajs: Not scanned.
X-mikrotik.com-Virus_un_spam-kerajs: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please don't include this.

what a good start...

> I'd prefer to switch i386 cpu selection to a different scheme which
> gives you effectively these options for free without additional options.

I admit, I might have missed the latest version of your patch, but in what I 
have seen, some functionality have been missing comparing to my patch                 
(do you have a possibility to compile a kernel especially for NexGen, 
Transmeta or UMC?), and it also changes user experience, which obviously 
should not happen in the stable branch. However, it might be a good idea to 
work on your patch for v 2.7.

Anyway, if you would like, I can separate CPU support part of the patch from 
the other parts...

Dmitry
