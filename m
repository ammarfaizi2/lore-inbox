Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUH1JlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUH1JlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUH1JlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:41:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:40327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267388AbUH1Jk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:40:58 -0400
Date: Sat, 28 Aug 2004 02:39:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [2/4] consolidate bit waiting code patterns
Message-Id: <20040828023909.5eac6b2d.akpm@osdl.org>
In-Reply-To: <20040828092210.GJ5492@holomorphy.com>
References: <20040826014745.225d7a2c.akpm@osdl.org>
	<20040828052627.GA2793@holomorphy.com>
	<20040828053112.GB2793@holomorphy.com>
	<20040827231713.212245c5.akpm@osdl.org>
	<20040828063419.GA5492@holomorphy.com>
	<20040827234033.2b6e1525.akpm@osdl.org>
	<20040828064829.GB5492@holomorphy.com>
	<20040828092040.GH5492@holomorphy.com>
	<20040828092210.GJ5492@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> --- mm1-2.6.9-rc1.orig/kernel/fork.c	2004-08-28 01:20:04.105925320 -0700
>  +++ mm1-2.6.9-rc1/kernel/fork.c	2004-08-28 01:23:00.542102944 -0700

Sorry, but I think we might as well dtrt here and move all this waity code
into kernel/wait.c - it's silly keeping it in fork.c.

And logically, that should be patch #1 of N.


