Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270940AbUJVETt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270940AbUJVETt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270899AbUJVEQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 00:16:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53971 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S270941AbUJUUZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:25:50 -0400
Subject: Re: IA32 (2.6.9 - 2004-10-20.21.30) - 11 New warnings (gcc 3.2.2)
From: Lee Revell <rlrevell@joe-job.com>
To: root@chaos.analogic.com
Cc: John Cherry <cherry@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410210942230.11962@chaos.analogic.com>
References: <200410211240.i9LCeDk8015277@cherrypit.pdx.osdl.net>
	 <Pine.LNX.4.61.0410210942230.11962@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1098390149.3705.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 16:22:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 09:44, Richard B. Johnson wrote:
> On Thu, 21 Oct 2004, John Cherry wrote:
> 
> > drivers/char/mem.c:213: warning: `remap_page_range' is deprecated
>   (declared at include/linux/mm.h:767)
> 
> Hmmm. What does one use instead???  We still use mmap in drivers
> or is that going to be removed too?

remap_pfn_range I think.

Lee



