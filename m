Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTL2WWC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbTL2WWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:22:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:53662 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264289AbTL2WWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:22:00 -0500
Date: Mon, 29 Dec 2003 14:21:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Thomas Molina wrote:
>
> I just finished a couple of comparisons between 2.4 and 2.6 which seem to 
> confirm my impressions.  I understand that the comparison may not be 
> apples to apples and my methods of testing may not be rigorous, but here 
> it is.  In contrast to some recent discussions on this list, this test is 
> a "real world" test at which 2.6 comes off much worse than 2.4.  

Are you sure you have DMA enabled on your laptop disk? Your 2.6.x system 
times are very high - much bigger than the user times. That sounds like 
PIO to me.

		Linus
