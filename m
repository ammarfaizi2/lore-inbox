Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267429AbUH1J6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267429AbUH1J6F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUH1J5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:57:35 -0400
Received: from holomorphy.com ([207.189.100.168]:40613 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267429AbUH1Jvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:51:41 -0400
Date: Sat, 28 Aug 2004 02:51:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [2/4] consolidate bit waiting code patterns
Message-ID: <20040828095134.GN5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, oleg@tv-sign.ru,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040828052627.GA2793@holomorphy.com> <20040828053112.GB2793@holomorphy.com> <20040827231713.212245c5.akpm@osdl.org> <20040828063419.GA5492@holomorphy.com> <20040827234033.2b6e1525.akpm@osdl.org> <20040828064829.GB5492@holomorphy.com> <20040828092040.GH5492@holomorphy.com> <20040828092210.GJ5492@holomorphy.com> <20040828023909.5eac6b2d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828023909.5eac6b2d.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> --- mm1-2.6.9-rc1.orig/kernel/fork.c	2004-08-28 01:20:04.105925320 -0700
>>  +++ mm1-2.6.9-rc1/kernel/fork.c	2004-08-28 01:23:00.542102944 -0700

On Sat, Aug 28, 2004 at 02:39:09AM -0700, Andrew Morton wrote:
> Sorry, but I think we might as well dtrt here and move all this waity code
> into kernel/wait.c - it's silly keeping it in fork.c.
> And logically, that should be patch #1 of N.

Okay, that and the test_bit() before calling bit_waitqueue() will take
a few minutes to do.


-- wli
