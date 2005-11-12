Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVKLWuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVKLWuu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVKLWuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:50:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:57303 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964877AbVKLWut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:50:49 -0500
Date: Sat, 12 Nov 2005 13:47:41 -0800
From: Greg KH <greg@kroah.com>
To: Luke Yang <luke.adi@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Message-ID: <20051112214741.GB16334@kroah.com>
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com> <20051101165136.GU8009@stusta.de> <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com> <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com> <20051104230644.GA20625@kroah.com> <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com> <20051107165928.GA15586@kroah.com> <20051107235035.2bdb00e1.akpm@osdl.org> <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 07:26:31PM +0800, Luke Yang wrote:
> > One concern when adding a new architecture is: will it be maintained
> > long-term?  We don't want to merge an arch and then have it bitrot.  Who is
> > behind this port, and how do we know that they'll still be around and doing
> > things in two years' time?
> 
>    I don't clearly know the process of maintaining an arch in kernel. 
> But I am sure we can follow the right process.  My question is: How do
> they maintain the m68knommu arch? I think it need the uclinux patch to
> run on real platfrom. What is the process like?

The process is like maintaining any other part of the kernel:
  - Try to make sure it works on all releases (harder to do with a full
    arch, I know, but not impossible.)
  - keep it up to date with bugfixes and the such
  - be responsive to questions from other developers
  - accept patches from others and intregrate them into the mainline
    version in a reasonable ammount of time.

Does this arch have corporate support behind it to maintain it over
time, or is something you are going to do in your spare time (which is
fine, just curious.)

thanks,

greg k-h
