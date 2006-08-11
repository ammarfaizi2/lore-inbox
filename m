Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWHKGyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWHKGyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160994AbWHKGyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:54:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:11218 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932382AbWHKGyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:54:37 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for review] [9/145] x86_64: Cleanup NMI interrupt path
Date: Fri, 11 Aug 2006 08:54:20 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200608110240_MC3-1-C7C3-777B@compuserve.com>
In-Reply-To: <200608110240_MC3-1-C7C3-777B@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608110854.20869.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 08:37, Chuck Ebbert wrote:
> In-Reply-To: <20060810193521.6A8C513B90@wotan.suse.de>
> 
> On Thu, 10 Aug 2006 21:35:21 +0200, Andi Kleen wrote:
> 
> > arch/i386/kernel/nmi.c     |   16 +++++++++++++---
> > arch/i386/kernel/traps.c   |   24 +++++++++++-------------
> > arch/x86_64/kernel/nmi.c   |   26 +++++++++++++++++++-------
> > arch/x86_64/kernel/traps.c |    8 ++++----
> > include/asm-i386/nmi.h     |    2 +-
> > include/asm-x86_64/nmi.h   |   10 +++++++++-
> 
> Could you please change the title of this patch to "x86: whatever"
> instead of "x86_64: whatever" so someone scanning titles can see
> it affects i386?

Done.

-Andi

