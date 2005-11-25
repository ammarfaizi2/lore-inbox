Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVKYKng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVKYKng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 05:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbVKYKng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 05:43:36 -0500
Received: from silver.veritas.com ([143.127.12.111]:8281 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751436AbVKYKnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 05:43:35 -0500
Date: Fri, 25 Nov 2005 10:43:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Con Kolivas <kernel@kolivas.org>
cc: Keith Owens <kaos@ocs.com.au>, Dave Jones <davej@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Kenneth W <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:491
In-Reply-To: <200511251050.02833.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0511251040460.5479@goblin.wat.veritas.com>
References: <25093.1132876061@ocs3.ocs.com.au> <200511251050.02833.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Nov 2005 10:43:34.0913 (UTC) FILETIME=[15E89F10:01C5F1AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2005, Con Kolivas wrote:
> On Fri, 25 Nov 2005 10:47, Keith Owens wrote:
> > On Thu, 24 Nov 2005 07:50:49 +0000 (GMT),
> > Hugh Dickins <hugh@veritas.com> wrote:
> > >On Wed, 23 Nov 2005, Dave Jones wrote:
> > >>
> > >> The 'G' seems to confuse a hell of a lot of people.
> > >> (I've been asked about it when people got machine checks a lot over
> > >>  the last few months).
> > >>
> > >> Would anyone object to changing it to conform to the style of
> > >> the other taint flags ? Ie, change it to ' ' ?
> > >
> > >Please, please do: it's insane as is.  But I've CC'ed Keith,
> > >we sometimes find the kernel does things so to suit ksymoops.
> >
> > 'G' is not one of mine, I find it annoying as well.
> 
> Would anyone object to changing it so that tainted only means Proprietary 
> taint and use a different keyword for GPL tainting such as "Corrupted"?

I don't see the point.  The system is in a dubious state, tainted is
the word we've been using for that, the flags indicate what's suspect,
why play with the wording further?  But replace 'G' by ' ' certainly.

Hugh
