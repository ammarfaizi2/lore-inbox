Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVC2XfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVC2XfI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVC2XfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:35:08 -0500
Received: from pat.uio.no ([129.240.130.16]:54437 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261656AbVC2Xef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:34:35 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112139155.5386.35.camel@mindpipe>
References: <1112137487.5386.33.camel@mindpipe>
	 <1112138283.11346.2.camel@lade.trondhjem.org>
	 <1112139155.5386.35.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 18:34:23 -0500
Message-Id: <1112139263.11892.0.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.424, required 12,
	autolearn=disabled, AWL 1.53, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 29.03.2005 Klokka 18:32 (-0500) skreiv Lee Revell:
> On Tue, 2005-03-29 at 18:18 -0500, Trond Myklebust wrote:
> > ty den 29.03.2005 Klokka 18:04 (-0500) skreiv Lee Revell:
> > > I am seeing long latencies in the NFS client code.  Attached is a ~1.9
> > > ms latency trace.
> > 
> > What kind of workload are you using to produce these numbers?
> > 
> 
> Just a kernel compile over NFS.

In other words a workload consisting mainly of mmap()ed writes?

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

