Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275798AbRJBEqr>; Tue, 2 Oct 2001 00:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275806AbRJBEqi>; Tue, 2 Oct 2001 00:46:38 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:39440 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275798AbRJBEqV>; Tue, 2 Oct 2001 00:46:21 -0400
Message-ID: <3BB946B4.C7479C16@zip.com.au>
Date: Mon, 01 Oct 2001 21:46:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ext3 0.9.10 for Alan's tree
In-Reply-To: <1001989916.2780.61.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> Stephen, Andrew:
> 
> Alan has said recently that he would merge a newer ext3 soon as the
> maintainer sends him such a patch, but no sooner.  That was in response
> to a few users asking why ext3 was "outdated" in his tree.

Yes, sorry.  It's turning out to be a lot of work keeping the master
ext3 tree in sync with two (rather different) kernels, and running around
after all the changes which are happening in (ahem) one of them.

We prefer to test a lot before releasing, and the one time I skipped
that step was for 2.4.10, and it was the one which is broken. Sigh.

> Attached is a patch against 2.4.10-ac3 of ext-0.9.9 + Ted's directory
> speedup.  Bringing 0.9.10 inline with Alan will take some VM work, but
> this is a start.

Rob, I've added this patch to the download site for interested parties
to use.  http://www.uow.edu.au/~andrewm/linux/ext3/

But for a merge with Alan we do have a few more changes backed up,
and some more testing must be done.  I'll try to prepare 0.9.11
for -ac this week.  I'm inclined to down-tools on Linus kernels
for a while, wait for things to settle down there.

Thanks!

-
