Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUJGRlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUJGRlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUJGRJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:09:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39599 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267516AbUJGQwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:52:22 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Patrick Gefre <pfg@sgi.com>
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Thu, 7 Oct 2004 09:52:02 -0700
User-Agent: KMail/1.7
Cc: Grant Grundler <iod00d@hp.com>, Colin Ngam <cngam@sgi.com>,
       "Luck, Tony" <tony.luck@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <200410061344.38265.jbarnes@engr.sgi.com> <41655A91.1010307@sgi.com>
In-Reply-To: <41655A91.1010307@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410070952.02291.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 7, 2004 8:02 am, Patrick Gefre wrote:
> > They should each be separate cleanup patches.  What I've done in the past
> > is make copies (in this case 5) of the big patch.  Then I edit all of
> > them to include only the hunks I want there.  Hopefully that'll minimize
> > the pain of respinning the big patch (i.e. no respin).  Also, Tony
> > doesn't want to deal with the above files, patches for them should be
> > sent to Andrew as separate mails with lkml in the cc list.
>
> These are not cleanup.
>
> The mmtimer code and sn_console include a file that doesn't exist anymore
> in the directory included - it's moved to somewhere else in the 002 patch.
>
> snsc.c, sgiioc4.c have changes for things that won't exist after this patch
> is applied.

Yeah, sorry, I shouldn't have said cleanup, fixup is better.  Anyway, they 
need to be separate since they'll be going into the tree via Andrew not Tony.

Thanks,
Jesse
