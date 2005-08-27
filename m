Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbVH0SwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbVH0SwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 14:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbVH0SwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 14:52:25 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:17718 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751582AbVH0SwY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 14:52:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RqP/4vn+zQtY16eMZQlXdvROM63DtnENev43nIqCdNk2m3NrvIDi+LqVVoG5X/OiEh0LXgokahLC0C/Stbn4QKzHFu5vJTMSohYN7/X2gQ6Q4QeKQ1Pi9QghCBEWjiDUPYFTA/a0CKPKfe819c8geFvorhdXfSk9tEiA67ywBjQ=
Message-ID: <5a4c581d05082711524f337f72@mail.gmail.com>
Date: Sat, 27 Aug 2005 20:52:21 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: "J. B." <ierland@mail.be>
Subject: Re: kernel compile error in bootsplash.c
Cc: rdunlap@xenotime.net, linux-kernel@vger.kernel.org
In-Reply-To: <11350200.1125168517801.JavaMail.root@orville>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <16842018.1125165215948.JavaMail.root@orville>
	 <20050827113427.4ab46fa3.rdunlap@xenotime.net>
	 <11350200.1125168517801.JavaMail.root@orville>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/05, J. B. <ierland@mail.be> wrote:
> if got it from
>  ftp://ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
> and applied some patches

The problem resides in the "some patches" then - as Randy said,
 bootsplash.c isn't in kernel.org kernels.

> > ----------------------------------------
> > From: Randy.Dunlap <rdunlap@xenotime.net>
> > Sent: Sat Aug 27 20:34:27 CEST 2005
> > To: J. B. <ierland@mail.be>
> > Subject: Re: kernel compile error in bootsplash.c
> >
> >
> > On Sat, 27 Aug 2005 19:53:35 +0200 (CEST) J. B. wrote:
> >
> > > I try to compile a 2.6.10 kernel but it stops with an error
> > > in bootsplash.c. I have everything set in my .config file in /usr/src/linux for bootsplash support.
> > >
> > > Anybody an idea. Where should i start to look? I am a newbie in kernel world
> >
> > This is in a vendor kernel, right?
> > So please take it up with that vendor.
> >
> > Kernels from kernel.org don't contain drivers/video/bootsplash/*
> >
> >
> > > in file included from drivers/video/bootsplash/bootsplash.c:18:
> > > include/linux/fb.h:869: error: array type has incomplete element type
> > > drivers/video/bootsplash/bootsplash.c:37: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:38: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:39: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:40: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:41: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:42: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:43: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:44: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:45: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:46: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:47: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:48: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:49: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:50: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:52: warning: pointer targets in initialization differ in signedness
> > > drivers/video/bootsplash/bootsplash.c: In function 'splash_verbose':
> > > drivers/video/bootsplash/bootsplash.c:572: warning: pointer targets in passing argument 1 of 'splashcopy' differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:572: warning: pointer targets in passing argument 2 of 'splashcopy' differ in signedness
> > > drivers/video/bootsplash/bootsplash.c: In function 'splash_prepare':
> > > drivers/video/bootsplash/bootsplash.c:642: warning: pointer targets in passing argument 1 of 'splashcopy' differ in signedness
> > > drivers/video/bootsplash/bootsplash.c: In function 'splash_write_proc':
> > > drivers/video/bootsplash/bootsplash.c:788: warning: pointer targets in passing argument 1 of 'boxit' differ in signedness
> > > drivers/video/bootsplash/bootsplash.c:789: warning: pointer targets in passing argument 1 of 'boxit' differ in signedness
> > > make[5]: *** [drivers/video/bootsplash/bootsplash.o] Error 1
> > > make[4]: *** [drivers/video/bootsplash] Error 2
> > > make[3]: *** [drivers/video] Error 2
> > > make[2]: *** [drivers] Error 2
> > > make[2]: Leaving directory `/usr/src/linux-2.6.10'
> > > make[1]: *** [stamp-build] Error 2
> > > make[1]: Leaving directory `/usr/src/linux-2.6.10'
> > > make: *** [stamp-buildpackage] Error 2

--alessandro

 "Not every smile means I'm laughing inside"

    (Wallflowers - "From The Bottom Of My Heart")
