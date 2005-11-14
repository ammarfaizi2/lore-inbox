Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVKNHea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVKNHea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 02:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVKNHea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 02:34:30 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:9911 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750948AbVKNHe3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 02:34:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s+WuqyRJW4gtOBu2oxm99JT/i5tINxTf/xF8IevwxD/3E5PsJXURC5j87nF7SsqpGSgBcGvQ2zyN5HzB9H3L6OpmZP7qzgEZSliLIik+2SE0j4ngioP8Cozi5Dys1YMKHzy2GRP93hg8Qhr2gTCYzPdjcdKqp7AFWn/883yYkt4=
Message-ID: <489ecd0c0511132334rc0d8a18n9ccf1bdd30d564a0@mail.gmail.com>
Date: Mon, 14 Nov 2005 15:34:29 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051112214741.GB16334@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	 <20051104230644.GA20625@kroah.com>
	 <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	 <20051107165928.GA15586@kroah.com>
	 <20051107235035.2bdb00e1.akpm@osdl.org>
	 <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
	 <20051112214741.GB16334@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Nov 11, 2005 at 07:26:31PM +0800, Luke Yang wrote:
> > > One concern when adding a new architecture is: will it be maintained
> > > long-term?  We don't want to merge an arch and then have it bitrot.  Who is
> > > behind this port, and how do we know that they'll still be around and doing
> > > things in two years' time?
> >
> >    I don't clearly know the process of maintaining an arch in kernel.
> > But I am sure we can follow the right process.  My question is: How do
> > they maintain the m68knommu arch? I think it need the uclinux patch to
> > run on real platfrom. What is the process like?
>
> The process is like maintaining any other part of the kernel:
>   - Try to make sure it works on all releases (harder to do with a full
>     arch, I know, but not impossible.)

  Does this include all the rc releases? and the 2.6.14.x releases?

>   - keep it up to date with bugfixes and the such

  So the process is: when kernel release a new version, we should
update our arch related files to the new kernel, then send you the
patch. Am I right?

>   - be responsive to questions from other developers

  No problem. We have a website(blackfin.uclinux.org) and a forum.

>   - accept patches from others and intregrate them into the mainline
>     version in a reasonable ammount of time.

   I totally understand.

>
> Does this arch have corporate support behind it to maintain it over
> time, or is something you are going to do in your spare time (which is
> fine, just curious.)

  Blackfin is one of the main DSP products of ADI. ADI has a growing
team supporting. I am one of the members.

regards,
Luke Yang
