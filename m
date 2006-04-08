Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWDHRHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWDHRHa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 13:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWDHRHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 13:07:30 -0400
Received: from wproxy.gmail.com ([64.233.184.237]:55103 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965029AbWDHRHa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 13:07:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N18hlpddRAb3iDsA/VzLOPIBBmI0qp6WgwUgxjvzvM2pNX9Vf9Gt5tzwXHumna3mEjXKJ6a6WYHcLzr51SRqycoRsQdJqECdSQ5dggKiJZ835uvGLYocof4G6G4TXkgJD+cpQTVa87DptkdSkDcSUoUsLnLt4308omH3AGSuhRY=
Message-ID: <5a4c581d0604081007t32863bf4n1253ebd8352dbf35@mail.gmail.com>
Date: Sat, 8 Apr 2006 19:07:28 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same kernel
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1144514167.2989.10.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
	 <5a4c581d0604080834k7961aff5l7794b8893325a90c@mail.gmail.com>
	 <1144511112.2989.8.camel@laptopd505.fenrus.org>
	 <5a4c581d0604080927g532b6d10y7992d9adb4e63d08@mail.gmail.com>
	 <1144514167.2989.10.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-04-08 at 18:27 +0200, Alessandro Suardi wrote:
> > On 4/8/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > >
> > > > Just for the record - no, even rebuilding same kernel with same GCC
> > > >  (3.4.4) under FC5, disk performance is much slower than FC3 -
> > > >  according to hdparm _and_ dd tests.
> > >
> > > what happens if you kill hald and other inotify using animals?
> >
> > Thanks Arjan for looking into this.
> >
> > Stopping hald brings hdparm from 18.5MB/s to 20MB/s, which is
> >  indeed a noticeable improvement, though still far from the FC3
> >  performance. I'm unsure what else can be stopped however
> >  from this process list:
> >
> >   274 ?        S<s    0:00 /sbin/udevd -d
>
>
> try killing that one next; it may or may not help but it's sure worth a
> try (esp given the success of the first kill :)

killing udevd doesn't bring any improvement - still at 20MB/s.

Do you want me to file a FC5 bugzilla entry with the current info
 or do you think there is something else that can be discussed
 on lkml ?

Thanks,

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)
