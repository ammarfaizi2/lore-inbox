Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269175AbUIBVhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269175AbUIBVhq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269206AbUIBVgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:36:35 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:21916 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S269184AbUIBVfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:35:21 -0400
Date: Thu, 2 Sep 2004 14:35:18 -0700
Message-Id: <200409022135.i82LZIBh003782@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
Cc: "'akpm@osdl.org'" <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix rusage semantics
In-Reply-To: Makhlis, Lev's message of  Thursday, 2 September 2004 16:29:08 -0500 <F12B6443B4A38748AFA644D1F8EF353214736C@bos-ex-01.adprod.bmc.com>
X-Fcc: ~/Mail/linus
X-Zippy-Says: Th' PINK SOCK... soaking... soaking... soaking...  Th' PINK
   SOCK... washing... washing... washing...  Th' PINK
   SOCK... rinsing... rinsing... rinsing...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no special opinions about what /proc files should report.
That has always been all quite ill-specified as far as I'm concerned.

> In an ideal world, I think /proc/PID/stat would report aggregate resource
> usage for the process, and /proc/PID/task/TID/stat would have resource
> usage for individual threads (in case anyone cares).  I'm including a
> patch against 2.6.9-rc1-bk9 that does just that.  

Sounds fine to me.


Thanks,
Roland
