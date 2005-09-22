Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbVIVAgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbVIVAgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 20:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVIVAgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 20:36:51 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:16258 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965195AbVIVAgv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 20:36:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KotnLCnjUXlVaBZaMVrgd07hET4FsZ+gS1DhI57mMc6uvkByEp+hley44EywOyo2cPWTMfuinQkwaVxGPvo+WOPT1ONZjeaiqpVmM4D0YyK2/Xz/iy+q+IX6KCHezLN6gQiobtXJJ3+If4HXQw2OAUxLdhmhvzFEFhthDbLigzE=
Message-ID: <2cd57c900509211736414cea32@mail.gmail.com>
Date: Thu, 22 Sep 2005 08:36:48 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: readme-update-from-the-stone-age.patch added to -mm tree
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200509211630.33242.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509202336.j8KNak00013479@shell0.pdx.osdl.net>
	 <2cd57c9005092019154758c826@mail.gmail.com>
	 <200509211630.33242.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> On Wednesday 21 September 2005 04:15, Coywolf Qi Hunt wrote:
> > On 9/21/05, akpm@osdl.org <akpm@osdl.org> wrote:
> > > The patch titled
> > >
> > >      README update from the stone age
> > >
> > > has been added to the -mm tree.  Its filename is
> > >
> > >      readme-update-from-the-stone-age.patch
> > >
> > >
>
> > > @@ -199,6 +199,9 @@ COMPILING the kernel:
> > >     are installing a new kernel with the same version number as your
> > >     working kernel, make a backup of your modules directory before you
> > >     do a "make modules_install".
> > > +   In alternative, before compiling, edit your Makefile and change the
> > > +   "EXTRAVERSION" line - its content is appended to the regular kernel
> > > +   version.
>
> > This is wrong. You expect users to both do menuconfig and edit top
> > Makefile manually?  What is the local version for then?
> Ok, yes, feel free to upgrade this to the use of CONFIG_LOCALVERSION. Or I can
> do it as well.
> --

CONFIG_LOCALVERSION is for normal users while "EXTRAVERSION" is for
developers to maintain different kernel trees.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
