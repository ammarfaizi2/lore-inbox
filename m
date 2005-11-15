Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVKOE3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVKOE3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVKOE3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:29:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:19894 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932371AbVKOE3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:29:17 -0500
Date: Mon, 14 Nov 2005 20:14:18 -0800
From: Greg KH <greg@kroah.com>
To: Luke Yang <luke.adi@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Message-ID: <20051115041418.GA20565@kroah.com>
References: <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com> <20051104230644.GA20625@kroah.com> <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com> <20051107165928.GA15586@kroah.com> <20051107235035.2bdb00e1.akpm@osdl.org> <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com> <20051112214741.GB16334@kroah.com> <489ecd0c0511132334rc0d8a18n9ccf1bdd30d564a0@mail.gmail.com> <1131954765.2821.6.camel@laptopd505.fenrus.org> <489ecd0c0511141840t4e7ba87ftfdba8c287063565f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489ecd0c0511141840t4e7ba87ftfdba8c287063565f@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:40:05AM +0800, Luke Yang wrote:
> On 11/14/05, Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > > > The process is like maintaining any other part of the kernel:
> > > >   - Try to make sure it works on all releases (harder to do with a full
> > > >     arch, I know, but not impossible.)
> > >
> > >   Does this include all the rc releases? and the 2.6.14.x releases?
> > >
> > > >   - keep it up to date with bugfixes and the such
> > >
> > >   So the process is: when kernel release a new version, we should
> > > update our arch related files to the new kernel, then send you the
> > > patch. Am I right?
> >
> > well the idea is that you fix things BEFORE the kernel is released for
> > final, so that the final releases work out of the box (well out of
> > kernel.org). This implies that you sort of track the git tree on a
> > regular basis, but at minimum look at the first -rc kernel.
> 
>   yep, that's our plan. And for the 2.6.14.1, 2.6.14.2... versions, do
> we have to follow every of them?

They should hopefully _not_ break anything, due to the small size of
those releases.  If they do, please let the stable team know.

thanks,

greg k-h
