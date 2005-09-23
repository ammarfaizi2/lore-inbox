Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVIWFhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVIWFhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 01:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVIWFhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 01:37:06 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:49708 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751302AbVIWFhF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 01:37:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P+VIuTaamgJNeLXkg6iekq2egOoLLNAwnQb8P0hoGxwY6hZSM+eCIv7TXx2pdn2fN2UC04b8Xso9gzHBB49L4qVl3LVi0+tRSUbXayAAph7rJB+KA/jeMaDlCNjf9PFrYkfG7E+v5dZ7Z0K7hgfXScuRiUEt4nNdUKai3t2K7Dg=
Message-ID: <489ecd0c050922223736cf1548@mail.gmail.com>
Date: Fri, 23 Sep 2005 13:37:03 +0800
From: Luke Yang <luke.adi@gmail.com>
Reply-To: Luke Yang <luke.adi@gmail.com>
Subject: Re: ADI Blackfin porting for kernel-2.6.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050920071514.GA10909@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c05091923336b48555@mail.gmail.com>
	 <20050920071514.GA10909@plexity.net>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   This is the ADI Blackfin patch for kernel 2.6.13.  I know this
patch doesn' meet the kernel patch submission format, but this patch
is only for reviewing, shows the changes we made.  And I'll send new
patch for kernel 2.6.14 for you to merge into kernel.

   This patch mainly includes the arch/bfinnommu architecture files
and some blackfin specific drivers.  The only change to the common
files is that we change binfmt.c and related header file, added one
flat binary format for blackfin. We are considering removing this
change in next release.

  The patch is too big to put here , url is
http://blackfin.uclinux.org/frs/download.php/570/bfinnonnu-linux-2.6.13.patch

  Thanks!
Luke

On 9/20/05, Deepak Saxena <dsaxena@plexity.net> wrote:
> On Sep 20 2005, at 14:33, Luke Yang was caught saying:
> > Hi,
> >
> >    I am Luke Yang, an engineer from Analog Devices Inc. We ported
> > uclinux to our Blackfin cpu. Now we updated our architecture code for
> > kernel-2.6.13. I will send out a patch to this list.
> >
> >    I know kernel-2.6.14 is coming. Will the linux kernel accept our
> > patch for 2.6.13?
>
> Nope. 2.6.13 is now closed to new features as is 2.6.14 (unless it is
> a really sper special case that Linus feels is important enough to slip
> in).  At this point the best thing to do is to post your patches for review,
> make the changes that are asked, and be ready to post a patch vs 2.6.14
> within the first week after it is released so that it might be be picked
> up for 2.6.15.
>
> ~Deepak
>
> --
> Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net
>
> Even a stopped clock gives the right time twice a day.
>
