Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262724AbTCJFSB>; Mon, 10 Mar 2003 00:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262725AbTCJFSB>; Mon, 10 Mar 2003 00:18:01 -0500
Received: from fmr05.intel.com ([134.134.136.6]:56826 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262724AbTCJFSA>; Mon, 10 Mar 2003 00:18:00 -0500
Subject: Re: Available watchdog test cases
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Paul Rolland <rol@as2917.net>
Cc: "'Paul Larson'" <plars@linuxtestproject.org>,
       "'lkml'" <linux-kernel@vger.kernel.org>
In-Reply-To: <008501c2e61f$fdd0a800$2101a8c0@witbe>
References: <008501c2e61f$fdd0a800$2101a8c0@witbe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Mar 2003 21:23:08 -0800
Message-Id: <1047273790.6399.13.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 01:40, Paul Rolland wrote:
> Just a quick question : is there an easy to force the kernel to Oops,
> to make sure that the watchdog will even be working under such
> conditions ?
> 
> I know people are all trying to avoid Oops... but I think the testplan
> should include that too...
> 
> Regards,
> Paul

You can write a kernel module that when loaded will disable all
interrupts and sit and spin, or even easier just call panic().

    --rustyl

