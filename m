Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbSJROlB>; Fri, 18 Oct 2002 10:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265106AbSJROlB>; Fri, 18 Oct 2002 10:41:01 -0400
Received: from [198.149.18.6] ([198.149.18.6]:23427 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265101AbSJROlB>;
	Fri, 18 Oct 2002 10:41:01 -0400
Date: Fri, 18 Oct 2002 18:00:31 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Christoph Hellwig <hch@sgi.com>, John Hesterberg <jh@sgi.com>,
       linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
Message-ID: <20021018180031.A27391@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Keith Owens <kaos@ocs.com.au>, John Hesterberg <jh@sgi.com>,
	linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>
References: <20021017224410.A25801@sgi.com> <29226.1034951870@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <29226.1034951870@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Oct 19, 2002 at 12:37:50AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 12:37:50AM +1000, Keith Owens wrote:
> On Thu, 17 Oct 2002 22:44:10 -0400, 
> Christoph Hellwig <hch@sgi.com> wrote:
> >On Thu, Oct 17, 2002 at 10:21:47AM -0500, John Hesterberg wrote:
> >> 2.5.43 versions of CSA, Job, and PAGG patches are available at:
> >>     ftp://oss.sgi.com/projects/pagg/download/linux-2.5.43-pagg-job.patch
> >>     ftp://oss.sgi.com/projects/csa/download/linux-2.5.43-csa.patch
> >
> >+#if defined (CONFIG_CSA_JOB_ACCT) || defined (CONFIG_CSA_JOB_ACCT_MODULE)
> >
> >Umm, stubbing stuff out based on _MODULE is a bad, bad idea.  Just make it
> >a bool instead.
> 
> The construct #if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE) is
> required for all CONFIG_FOO which can be defined as tristate.

Keith, I know that it works.  Which doesn't make it a good idea.

