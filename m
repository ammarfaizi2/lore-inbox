Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWBRAlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWBRAlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWBRAlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:41:06 -0500
Received: from secure.htb.at ([195.69.104.11]:4358 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1751809AbWBRAlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:41:05 -0500
Date: Sat, 18 Feb 2006 01:40:54 +0100
From: Richard Mittendorfer <delist@gmx.net>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [swsusp] not enough memory
Message-Id: <20060218014054.15bfc4f5.delist@gmx.net>
In-Reply-To: <200602181008.02801.ncunningham@cyclades.com>
References: <20060218005814.6548092d.delist@gmx.net>
	<200602181008.02801.ncunningham@cyclades.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FAG9g-0006r1-00*bGEBy.COSMY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Nigel Cunningham <ncunningham@cyclades.com> (Sat, 18 Feb
2006 10:07:58 +1000):
> Hi Richard.

Hello Nigel,
 
> On Saturday 18 February 2006 09:58, Richard Mittendorfer wrote:
> > swsusp: Need to copy 15526 pages
> > swsusp: Not enough free memory
> > Error -12 suspending
> > [...]
> swsusp needs to be able to free half your memory to be able to
> suspend. I  don't know it intimately, but you may well be failing to
> do this. Being  completely biased (and not unwilling to admit it!),
> I'd suggest you try  Suspend2 (www.suspend2.net). It doesn't have such
> a limitation.

Thanks for this hint. However, I'm using ck's patches and having errors 
compiling sched.c. Just took a quick look: I don't think I can get them 
working together. The  rest of the suspend2 patch (for 2.6.15.1) seems 
to apply fine to 2.6.15.4 also (Not much changes IIRC).  

> Regards,
> 
> Nigel

sl ritch
