Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274820AbTHPQYf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274838AbTHPQYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:24:35 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:16389 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S274820AbTHPQYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:24:34 -0400
Subject: Re: increased verbosity in dmesg
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: gene.heskett@verizon.net
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308161201.34125.gene.heskett@verizon.net>
References: <200308160438.59489.gene.heskett@verizon.net>
	 <200308161136.01133.gene.heskett@verizon.net>
	 <1061048708.624.0.camel@teapot.felipe-alfaro.com>
	 <200308161201.34125.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1061051071.891.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 16 Aug 2003 18:24:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-16 at 18:01, Gene Heskett wrote:

> Damn, grep must not look at .files, its there, and still 14.  Thanks a 
> bunch, new build underway.
> 
> However, I'd assume a make mrproper, or an oldconfig might reset that 
> to the include/config/log/buf/shift.h value?  Its also in 
> autoconfig.h FWTW.

"make mrproper" will destroy your ".config" file. And, AFAIK, "make
oldconfig" will only create CONFIG_LOG_BUF_SHIFT if it doesn't exist so,
if your ".config" does hold a concrete value, it will be kept even when
you run "make oldconfig".

