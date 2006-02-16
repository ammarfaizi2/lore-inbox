Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWBPNUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWBPNUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 08:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWBPNUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 08:20:49 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:16073 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1161049AbWBPNUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 08:20:49 -0500
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update: API changes
References: <Pine.LNX.4.44L0.0602101101350.5227-100000@iolanthe.rowland.org>
From: Jes Sorensen <jes@sgi.com>
Date: 16 Feb 2006 08:20:47 -0500
In-Reply-To: <Pine.LNX.4.44L0.0602101101350.5227-100000@iolanthe.rowland.org>
Message-ID: <yq0u0azxwwg.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Stern <stern@rowland.harvard.edu> writes:

Alan> The kernel's implementation of notifier chains is unsafe.  There
Alan> is no protection against entries being added to or removed from
Alan> a chain while the chain is in use.  The issues were discussed in
Alan> this thread:

Alan> http://marc.theaimsgroup.com/?l=linux-kernel&m=113018709002036&w=2

Hi,

I was wondering if there was anything blocking this change from going
in? I'd quite like to see it as it would avoid me from inventing yet
another notifier chain implementation ;-)

Cheers,
Jes
