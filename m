Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWDKSEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWDKSEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDKSEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:04:30 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:48330 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750911AbWDKSE3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:04:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fnrD/EagpVMPHOoAXv3ymgYrXWivaCgM7dhPsjU0AIKpzpRi/uS0sYC8PKdBXNowHzrwEJ20Qth+fM/YK3hI3QW24ovKT+4bOQSuhwS9hdhwJOxMWS/QUaRlzjpXnNSCPI68/Skg4DJIgYliYWjhdAjvqswlhYhYvJj6ZIg7K8g=
Message-ID: <5a4c581d0604111104y65f35e68ha9a5ff7e4061a9ea@mail.gmail.com>
Date: Tue, 11 Apr 2006 20:04:29 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same kernel
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0604111325140.928@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
	 <5a4c581d0604080834k7961aff5l7794b8893325a90c@mail.gmail.com>
	 <1144511112.2989.8.camel@laptopd505.fenrus.org>
	 <5a4c581d0604080927g532b6d10y7992d9adb4e63d08@mail.gmail.com>
	 <1144514167.2989.10.camel@laptopd505.fenrus.org>
	 <5a4c581d0604081007t32863bf4n1253ebd8352dbf35@mail.gmail.com>
	 <Pine.LNX.4.61.0604111325140.928@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> try killing that one next; it may or may not help but it's sure worth a
> >> try (esp given the success of the first kill :)
> >
> >killing udevd doesn't bring any improvement - still at 20MB/s.
> >
> >Do you want me to file a FC5 bugzilla entry with the current info
> > or do you think there is something else that can be discussed
> > on lkml ?
> >
>
> Compile a non-initrd kernel and run it with the -b parameter (it's passed
> to /sbin/init). From that shell, run your speed test. What does it show?

All my kernels are non-initrd (as long as I can do this in Fedora,
 I will do that). How do I pass -b to init ?

Thanks,

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)
