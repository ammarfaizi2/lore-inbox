Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbUKGNFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUKGNFB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUKGNFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:05:00 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:25443 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261607AbUKGNEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:04:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QQ1K4izQ+9dRAFVZu7cqko/noeLlqco3UfmNxi4Z5VNkNrmJiR/rWHoOYsstsurxfhHINvRXrT21pHZUGviJRJ7dkm5y8YdBFmDERrm2Zo7gVqmoblV8Na1Q8XgL8b8odHfsOjS1y32uHeUeXQ+lCyIGyd92OZ02qBvGMt6q/nQ=
Message-ID: <aad1205e04110705044faaacfb@mail.gmail.com>
Date: Sun, 7 Nov 2004 21:04:54 +0800
From: andyliu <liudeyan@gmail.com>
Reply-To: andyliu <liudeyan@gmail.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar file)
Cc: linux-kernel@vger.kernel.org, kaz@earth.email.ne.jp,
       jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net
In-Reply-To: <20041107.172838.74752953.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <aad1205e0411062306690c21f8@mail.gmail.com>
	 <418DCB2F.2030303@adsl-64-217-116-74.dsl.hstntx.swbell.net>
	 <aad1205e041106233274e78428@mail.gmail.com>
	 <20041107.172838.74752953.taka@valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Nov 2004 17:28:38 +0900 (JST), Hirokazu Takahashi
<taka@valinux.co.jp> wrote:
> Hi, Andyliu,
> 
> Amazing that you continue our work!
> Where did you get the code?
Thanks for your code, I got it form your web but i cannot connect to it now.

> 
> Several years ago, we - Kazuto and I -  made the filesystem
> just for magazine readers. We designed it as simple as we could,
> as it was a sample filesystem to explain about the design and the
> implementation of linux filesystems.
> 
I am a newbie.so your simple tar filesystem is good for me to learn 
and do something like make it run on 2.6.10-rc1-mm3.

> I guess there may remain many things to do about it:
>    - To support tar.gz and tar.bz2. I guess this should be done in
>      a compression device, which might be md layers or a loop device
>      itself.
>    - It may be better if you can make tarent objects free-able
>      while the filesystem is mounted.
>    - It may be possible to implement append mode.
>      A new file can be appended to the filesystem.
> 
> We're expecting you to do a good job.
> 
I am thinking how to make it support tar.gz type file.I will try my best.
> 
> 
> > oh,sorry.it's a readonly filesystem now.i will try to make it writeable.
> > but i use tar file as loop device.
> >
> > by the way,if we mount an iso file it's a readonly filesystem too.
> > i think maybe we should do something on the loop device to support
> > this kind of write.
> >
> > On Sun, 07 Nov 2004 07:13:51 +0000, James Tabor
> > <jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net> wrote:
> > > andyliu wrote:
> > >
> > >
> > > > hi
> > > >
> > > >   let's think about the way we access the file which contained in a tar file
> > > > may we can untar the whole thing and we find the file we want to access
> > > > or we can use the t option with tar to list all the files in the tar
> > > > and then untar the only one file we want to access.
> > > >
> > > >   but with the help of the tarfs,we can mount a tar file to some dir and access
> > > > it easily and quickly.it's like the tarfs in mc.
> > > >
> > > >  just mount -t tarfs tarfile.tar /dir/to/mnt -o loop
> > > > then access the files easily.
> > > >
> > > > it was writen by Kazuto Miyoshi (kaz@earth.email.ne.jp) Hirokazu
> > > > Takahashi (h-takaha@mub.biglobe.ne.jp) for linux 2.4.0
> 
> This address is no longer usable.
> 
> 
> 
> > > > and i make it work for linux 2.6.0. now a patch for linux 2.6.10-rc1-mm3
> > > >
> > > > the patch is to big to send it as plain text, so i can only send it as
> > > > an attachment
> > > >
> > > > thanks
> > > >
> > > Wow! How cool is this! Can you copy files into a tarfs subsystem? Just like
> > > we do with iso's?
> > > Cool,
> > > James
> 
> Thanks,
> Hirokazu Takahashi.
> 
> 


-- 
Yours andyliu
