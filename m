Return-Path: <linux-kernel-owner+w=401wt.eu-S1751351AbXAILB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbXAILB2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 06:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXAILB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 06:01:28 -0500
Received: from ns.suse.de ([195.135.220.2]:38276 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbXAILB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 06:01:27 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] x86_64: re-add a newline to RESTORE_CONTEXT
Date: Tue, 9 Jan 2007 12:01:21 +0100
User-Agent: KMail/1.9.5
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       "Steven M. Christey" <coley@mitre.org>
References: <20070109025516.GC25007@stusta.de>
In-Reply-To: <20070109025516.GC25007@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701091201.21146.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 January 2007 03:55, Adrian Bunk wrote:
> RESTORE_CONTEXT lost a newline in 
> commit 658fdbef66e5e9be79b457edc2cbbb3add840aa9:
> http://www.mail-archive.com/kgdb-bugreport@lists.sourceforge.net/msg00559.html

I don't think we should add such changes for external patchkits.

In general kgdb shouldn't add any patches at all. If the existing 
hooks are not enough they should submit their changes needed so
that it can just work.


-Andi
