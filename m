Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVLCVbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVLCVbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLCVbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:31:09 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:15008 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751251AbVLCVbI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:31:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kdrwQA1C2Y0kJTm23fK59StoMmHOClxHUgJMwdeQr1uNgP9u7/wFR2hs/TYSaf7rNL8SbgUZYbK6ix246Y0PC79i2yKBYoS3uJMZbMQVD+NY7Nzh/urkXZwODliGTzpNYADmlOAXUYxCv7SRXTt44l6B9bvSEVk1l4WJ1fD0VHQ=
Message-ID: <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
Date: Sat, 3 Dec 2005 22:31:03 +0100
From: "M." <vo.sinh@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051203211209.GA4937@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de>
	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>
	 <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
	 <20051203211209.GA4937@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/05, Greg KH <greg@kroah.com> wrote:
> <dragging the converstation back to lkml, where it belongs...>
>
> On Sat, Dec 03, 2005 at 09:54:35PM +0100, M. wrote:
> > On 12/3/05, Greg KH <greg@kroah.com> wrote:
> > > On Sat, Dec 03, 2005 at 03:29:54PM +0100, Jesper Juhl wrote:
> > > >
> > > > Why can't this be done by distributors/vendors?
> > >
> > > It already is done by these people, look at the "enterprise" Linux
> > > distributions and their 5 years of maintance (or whatever the number
> > > is.)
> > >
> > > If people/customers want stability, they already have this option.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Yes but not home users with relatively new/bleeding edge hardware or
> > small projects writing for example a wifi driver or a security patch
> > or whatever without full time commitment to tracking kernel changes.
>
> If you are a user that wants this kind of support, then use a distro
> that can handle this.  Obvious examples that come to mind are both
> Debian and Gentoo and Fedora and OpenSuSE, and I'm sure there are
> others.
>
> But if you are a developer, you can usually stay up to date by tracking
> the main releases, which should be about once a month.  If you have
> problems porting your stuff to the latest kernel when you need to submit
> it for inclusion, there are lots of people to help point you in the
> proper direction for what is needed to be done.
>
> > Enterprise products are suited for production servers,
> > school/government/companies desktops and not for "enthusiasts" or for
> > small kernel projects (they obviously cant write drivers or patches
> > for custom distro kernels). Those enthusiasts have to get mad with
> > performance regressions, new incompatibilities, new crashes etc.
>
> Sure, then use a different distro for them.  That's why Linux has so
> many different ones, they all are targeted at different users.
>
> thanks,
>
> greg k-h
>
<sorry for the direct reply>

makes sense, but are you sure having distros like Debian, enterprise
products from redhat etc using the same 6months release for their
stable versions does not translate in minor fragmentation on kernel
development and in benefits for every user?

Under this light i think a 6months cycle starts to mean something when
stable distros gets older and older (debian and redhat enterprise are
released every 18/24 months) and developers and who wants bleeding
edge features can always use Fedora, openSUSE, Gentoo etc. Another
advantage would be to benefit external projects and hardware producers
writing open drivers, enlowering the effort in writing and mantaining
a driver.

Michele
