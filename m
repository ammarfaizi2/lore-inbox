Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbTL2XEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265129AbTL2XEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:04:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:43704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265126AbTL2XEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:04:35 -0500
Date: Mon, 29 Dec 2003 15:04:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0312291502210.1586@home.osdl.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
 <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Thomas Molina wrote:
> 
> It certainly looks like DMA is enabled.

Indeed. Can you do a simple kernel profile? Either using oprofile or just
even the old profiler. It should show something (hopefully obvious), since
your load seems to have a _huge_ system load.

			Linus
