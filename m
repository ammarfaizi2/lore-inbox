Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbUJ0Qhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbUJ0Qhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUJ0Qee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:34:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:47835 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262508AbUJ0Qbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:31:48 -0400
Date: Wed, 27 Oct 2004 09:30:31 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
In-Reply-To: <20041027064851.GW15367@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0410270928270.17538@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
 <20041027064851.GW15367@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, William Lee Irwin III wrote:

> On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> > Hugetlb demand paging has been part of SuSE SLES 9 for awhile now and
> > this patchset is intended to help hugetlb demand paging also get into
> > the official Linux kernel. Huge pages are referred to as "compound"
> > pages in terms of "struct page" in the Linux kernel. The term
> "compund page" may be used alternatively to huge page.
>
> This may very well explain why SLES9 is triplefaulting when Oracle
> tries to use hugetlb on it on x86-64.
>
> Since all this is clearly malfunctioning and not done anywhere near
> carefully enough, can I at least get *some* sanction to do any of this
> differently?

The current SUSE implementation is a different implementation and has
severe limitations. They need a different implementation and
the suggestion was made to start with Ken's patches.
What would you like to do differently?
