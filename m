Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVCQWKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVCQWKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVCQWJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:09:46 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56003 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261258AbVCQWJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:09:30 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: KGDB question
Date: Thu, 17 Mar 2005 14:09:07 -0800
User-Agent: KMail/1.7.2
Cc: "Abhinkar, Sameer" <sameer.abhinkar@intel.com>,
       linux-kernel@vger.kernel.org
References: <D30E01168D637641AA9D3667F3BB741603F9125F@orsmsx403.amr.corp.intel.com> <20050317135417.6cee8336.akpm@osdl.org>
In-Reply-To: <20050317135417.6cee8336.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503171409.07290.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 17, 2005 1:54 pm, Andrew Morton wrote:
> "Abhinkar, Sameer" <sameer.abhinkar@intel.com> wrote:
> > Are there any patches or hooks
> > available to enable KGDB for linux-2.6.11.2?
>
> kgdb patches are maintained in -mm kernels.
>
> Patches are in
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
>-mm1/broken-out/*kgdb*
>
> And the patch application order is described in
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
>-mm1/patch-series -

What's the latest status on these?  Last I heard, some cleanup was going to 
happen to make kgdb suitable for the mainline, did that ever happen?  Also, 
it would be nice if I could connect to a remote kernel running the kgdb stubs 
w/o having to run gdb on the same ethernet segment.  Would that be difficult 
to fix?

Thanks,
Jesse
