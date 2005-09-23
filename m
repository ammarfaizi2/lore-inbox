Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVIWW7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVIWW7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 18:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVIWW7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 18:59:17 -0400
Received: from xenotime.net ([66.160.160.81]:46471 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751340AbVIWW7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 18:59:17 -0400
Date: Fri, 23 Sep 2005 15:59:14 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Franck <vagabon.xyz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to add a new ram region ?
Message-Id: <20050923155914.0e13e0e5.rdunlap@xenotime.net>
In-Reply-To: <cda58cb805092300496abc8350@mail.gmail.com>
References: <cda58cb805092300496abc8350@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005 09:49:43 +0200 Franck wrote:

> Hi,
> 
> I'm working on port of linux 2.6.13. The target is a custom board
> based on a MIPS cpu. There are several RAMs on this board whose
> address are not contiguous and don't start to 0 . I currently succeed
> to make linux detect one of these RAM (the biggest one) but I'd like
> to make linux able to use the others...I'd like to use the other in a
> particular way: I would like to be able to allocate memory only on a
> single RAM when needed in kernel space, and in userspace I would be
> able to export a RAM disk that uses memory on a single RAM.
> 
> Could someone tell me how to do that or give me some pointers  ?

You can try the "memmap=" kernel boot options, although I don't
know if or how well they apply to MIPS.  Some of them apparently
do apply, according to Documentation/kernel-parameters.txt .

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
