Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVELPs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVELPs3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 11:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVELPs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 11:48:29 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:64986 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262055AbVELPsV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 11:48:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gsULfJ9C5QPuvTvjWVEX4g+MaJavcQmKTalDxA3QKv4Kx+qpvk3uSOs7gx0z4ueSfY+wnXLC8r9r8aOrGQVs5O3d/pmnjmqZ31LNWTGMMWGrjXIGblGu5NVmsUiaO5yYdEngagDdBvUVOJh67plb9o/f1tB1Ycm5YMD41i6AQsw=
Message-ID: <3993a49805051208483af748e@mail.gmail.com>
Date: Thu, 12 May 2005 17:48:20 +0200
From: Jouke Witteveen <j.witteveen@gmail.com>
Reply-To: Jouke Witteveen <j.witteveen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Compile third-party module into the kernel
In-Reply-To: <3993a4980505120819d558bb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3993a49805050908221f005d61@mail.gmail.com>
	 <87ab37ab050509211458b25ff0@mail.gmail.com>
	 <3993a498050510082525d8f8e2@mail.gmail.com>
	 <3993a4980505120819d558bb0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops:
The right address of the patch is:
http://developer.momonga-linux.org/viewcvs/trunk/pkgs/kernel24/momonga-linux-2.4.20-3c90x.patch

I see now that it is designed for 3com driver version 1.0.0i. Does
that mean I cannot use it with version 1.0.2?

- Jouke

On 5/12/05, Jouke Witteveen <j.witteveen@gmail.com> wrote:
> Can I use this patch:
> http://developer.momonga-linux.org/viewcvs/trunk/pkgs/kernel/momonga-linux-2.4.20-3c90x.patch?rev=3
> on the Debianized source 2.4.27 (rev 8)?
> 
> - Jouke
> 
> On 5/10/05, Jouke Witteveen <j.witteveen@gmail.com> wrote:
> > In the readme file from the drivers in question is stated:
> > ---
> > > To load the 3C90x driver module on a Kernel 2.4 (or above) system,
> > > place an "alias" in the file named /etc/modules.conf.
> > > For older systems, the file name may be conf.modules.
> > ---
> > This is the only time the 2.4 branch gets metioned.
> > From this I can conclude that the driver does support the 2.4 branch
> > but it is not build for this specific linux kernel.
> > How to compile it into the kernel is not described however.
> >
> > In an older version of the driver
> > (http://support.3com.com/infodeli/tools/nic/linux/3c90x-1.0.0i.tar.gz)
> > a patch for the 2.2 series kernel source is included.
> > How should I patch the 2.4.27 kernel source to include the 3c90x?
> >
> >
> > On 5/10/05, kylin <fierykylin@gmail.com> wrote:
> > > is third party soft writen for the specific linux kernnel ?
> > >
> > > On 5/9/05, Jouke Witteveen <j.witteveen@gmail.com> wrote:
> > > > Hello,
> > > >
> > > > I'm about to compile my new 2.4.27 (Debian Sarge) kernel. There is
> > > > only one hurdle left to take.
> > > > For my 3C905C-TX-M I wan't to use the latest vendor driver since I
> > > > heard the famous 3c59x is not optimal for that card. The driver of
> > > > choice is: http://support.3com.com/infodeli/tools/nic/linux/3c90x-102.tar.gz.
> > > > How do I compile this source (3c90x.c and 3c90x.h) directly into the
> > > > kernel (not as a module)? And how as a module inside a
> > > > my-kernel_modules.deb like ALSA
> > > > get's compiled?
> > > >
> > > > Kind regards,
> > > > Jouke
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > >
> > >
> > > --
> > > we who r about to die,salute u!
> > >
> >
>
