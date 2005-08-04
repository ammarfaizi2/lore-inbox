Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVHDRLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVHDRLu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVHDRLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:11:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12215 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262596AbVHDRJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:09:44 -0400
Date: Thu, 4 Aug 2005 10:08:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: nacc@us.ibm.com, arjan@infradead.org, domen@coderock.org,
       linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] push rounding up of relative request to
 schedule_timeout()
Message-Id: <20050804100810.293c9ba6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0508041123220.3728@scrub.home>
References: <1122123085.3582.13.camel@localhost.localdomain>
	<Pine.LNX.4.61.0507231456000.3728@scrub.home>
	<20050723164310.GD4951@us.ibm.com>
	<Pine.LNX.4.61.0507231911540.3743@scrub.home>
	<20050723191004.GB4345@us.ibm.com>
	<Pine.LNX.4.61.0507232151150.3743@scrub.home>
	<20050727222914.GB3291@us.ibm.com>
	<Pine.LNX.4.61.0507310046590.3728@scrub.home>
	<20050801193522.GA24909@us.ibm.com>
	<Pine.LNX.4.61.0508031419000.3728@scrub.home>
	<20050804005147.GC4255@us.ibm.com>
	<Pine.LNX.4.61.0508041123220.3728@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Andrew, please drop this patch. 

Well I was sitting on them with the intention of taking a look later and
trying to work out what the heck you two have been going on about.

But maybe dropping them means that we'll later get a clear and concise
description of the problem and its solution, so I'll do that.

(This was supposed to be just a simple "consolidate
set_current_state+schedule_timeout into a single function call" patch. 
What happened?)
