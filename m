Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUIVSpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUIVSpP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUIVSpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:45:15 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:23559 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266626AbUIVSpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:45:11 -0400
Message-ID: <4151C9FB.8040100@techsource.com>
Date: Wed, 22 Sep 2004 14:52:43 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: jmerkey@comcast.net, alan@lxorguk.ukuu.org.uk, wli@holomorphy.com,
       roland@topspin.com, linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
References: <083020040556.26446.4132C1810009E19F0000674E2200751150970A059D0A0306@comcast.net> <20040830111019.5ddc99ab.rddunlap@osdl.org>
In-Reply-To: <20040830111019.5ddc99ab.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I feel like I've missed something in this discussion.

First of all I really don't understand the cause of the lost 128K in the 
first place, but it seems that by increasing the address space reserved 
for the kernel in user space by some amount fixes this problem.

My question is:  Why can't we just shrink the kernel address space by 
that same amount, allowing the kernel address space plus the extra to 
fit into 1GB?

