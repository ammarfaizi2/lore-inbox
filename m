Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUKGHc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUKGHc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 02:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbUKGHc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 02:32:29 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:15266 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261552AbUKGHcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 02:32:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aJdylnKgNiYfmpJCpUIpVUcKALlj6UHcy/v+ImuUmMxJBlbUv1viICiVWWO2pRMkxnMn1IarebzBDp6M8vMAGHrkPRtoBp3bCAf0YO7u6a05gFpvJ4BoV6HVLvvYRN5S830VPYxzTDD+Dku1b8/nBcqcahqRwTiMBTJ/HufgJJg=
Message-ID: <aad1205e041106233274e78428@mail.gmail.com>
Date: Sun, 7 Nov 2004 15:32:23 +0800
From: andyliu <liudeyan@gmail.com>
Reply-To: andyliu <liudeyan@gmail.com>
To: James Tabor <jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net>
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar file)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <418DCB2F.2030303@adsl-64-217-116-74.dsl.hstntx.swbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <aad1205e0411062306690c21f8@mail.gmail.com>
	 <418DCB2F.2030303@adsl-64-217-116-74.dsl.hstntx.swbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oh,sorry.it's a readonly filesystem now.i will try to make it writeable.
but i use tar file as loop device.

by the way,if we mount an iso file it's a readonly filesystem too.
i think maybe we should do something on the loop device to support
this kind of write.

On Sun, 07 Nov 2004 07:13:51 +0000, James Tabor
<jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net> wrote:
> andyliu wrote:
> 
> 
> > hi
> >
> >   let's think about the way we access the file which contained in a tar file
> > may we can untar the whole thing and we find the file we want to access
> > or we can use the t option with tar to list all the files in the tar
> > and then untar the only one file we want to access.
> >
> >   but with the help of the tarfs,we can mount a tar file to some dir and access
> > it easily and quickly.it's like the tarfs in mc.
> >
> >  just mount -t tarfs tarfile.tar /dir/to/mnt -o loop
> > then access the files easily.
> >
> > it was writen by Kazuto Miyoshi (kaz@earth.email.ne.jp) Hirokazu
> > Takahashi (h-takaha@mub.biglobe.ne.jp) for linux 2.4.0
> >
> > and i make it work for linux 2.6.0. now a patch for linux 2.6.10-rc1-mm3
> >
> > the patch is to big to send it as plain text, so i can only send it as
> > an attachment
> >
> > thanks
> > 
> Wow! How cool is this! Can you copy files into a tarfs subsystem? Just like
> we do with iso's?
> Cool,
> James
> 


-- 
Yours andyliu
