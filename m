Return-Path: <linux-kernel-owner+w=401wt.eu-S932573AbXART6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbXART6A (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 14:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbXART6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 14:58:00 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:12205 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573AbXART57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 14:57:59 -0500
In-Reply-To: <adavej4b1vi.fsf@cisco.com>
Subject: Re: [PATCH/RFC 2.6.21] ehca: ehca_uverbs.c: refactor ehca_mmap() for	better
 readability
To: Roland Dreier <rdreier@cisco.com>
Cc: hch@infradead.org, Christoph Raisch <raisch@de.ibm.com>,
       Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF2AD534B2.A4948D9F-ONC1257267.006D39E5-85257267.006DAB06@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Thu, 18 Jan 2007 14:57:54 -0500
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF882 | September 26, 2006) at
 18/01/2007 20:57:55
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No problem. Will resend the full patch set for 2.6.21.
Thanks
Nam

linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org wrote on 18.01.2007
13:56:01:

> I've kind of lost the plot here.  How does this patch fit in with the
> previous series of patches you posted?  Does it replace them or go on
> top of them?
>
> Can please you resend me the full series of patch that remove the use
> of do_mmap(), with all cleanups and bug fixes included?  And please
> roll up the fixes, I don't want one patch that adds a yield() inside a
> spinlock and then a later patch to fix it -- there's no sense in
> adding landmines for people potentially doing git bisect in the
> future.
>
> And also please try to split the patches so that they don't mix
> together two things -- please try to make the "remove obsolete
> prototypes" patch separate from the mmap fixes.
>
> Thanks...
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

