Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271179AbUJVC3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271179AbUJVC3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbUJVC3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:29:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:50064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271179AbUJVCNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:13:45 -0400
Date: Thu, 21 Oct 2004 19:11:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net
Subject: Re: [PATCH 2.6.9 0/2] enhanced accounting data collection
Message-Id: <20041021191137.528ab638.akpm@osdl.org>
In-Reply-To: <41785FE3.806@engr.sgi.com>
References: <41785FE3.806@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@engr.sgi.com> wrote:
>
> These two patches are the one we submitted to SuSE for Sles9 SP1.

Did suse accept them?

> They are clean of CSA specific code.
> 
> In earlier round of discussion, all partipants favored  a common
> layer of accounting data collection. I believe these two patches are
> the super set that meets the needs of people who need enhanced BSD 
> accounting.

OK, well I shall assume that all participants are reading lse-tech, or that
readers of lse-tech will pass on the appropriate heads-up.  Because if I
don't hear from anyone, this all goes in.

> This patchset consists of two parts: acct_io and acct_mm, as we
> identified improved data collection in the area of IO and MM are
> useful to our customers.
> 
> It is intended to offer common data collection method for various
> accounting packages including BSD accouting, ELSA, CSA, and any other
> acct packages that favor a common layer of data collection.
> 
> 'acct_mm' defines a few macros that are no-op unless
> CONFIG_BSD_PROCESS_ACCT config flag is set on.
> 
> Andrew, please consider including these two patches. Please let me
> know how i can help!

These patches are really, really badly documented.  This is by no means
unusual, but I labour on.  A nice description of what you set out to do and
how you did it would be a nice thing to present.

I have a few comments on the present implementation and shall follow up to
those patches.

