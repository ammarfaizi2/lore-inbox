Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266088AbUBCUpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266100AbUBCUpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:45:04 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:36360 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266088AbUBCUpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:45:00 -0500
Message-ID: <4020096B.7000408@techsource.com>
Date: Tue, 03 Feb 2004 15:49:47 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Auto-regulated swappiness
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed the kerneltrap article about Con's new patchset.  In 
particular, I am curious about the auto-regulated swappiness.

I've done a little searching through the archives, but I can't seem to 
find the lkml posts I'm thinking about.  In any event, I vaguely 
remember two things:

- auto-regulation was developed because the kernel seemed to swap too 
much or too little under certain circumstances.

- Someone said that auto-regulating swappiness didn't make sense, 
because there was some constant value that should have had the desired 
effect.

I don't remember there being a resolution to this discussion.

For my own curiosity, what happens if swappiness is too high but there 
isn't any pressure to swap from memory usage?  Do user pages get swapped 
out in favor of making room for potential buffer pages?

What happens if it's too low and there's lots of pressure to swap?

How does the auto-regulator fix this?

Thanks.

