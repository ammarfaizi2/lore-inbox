Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWDHQgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWDHQgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWDHQgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:36:10 -0400
Received: from [4.79.56.4] ([4.79.56.4]:62647 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965021AbWDHQgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:36:09 -0400
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same
	kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0604080927g532b6d10y7992d9adb4e63d08@mail.gmail.com>
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
	 <5a4c581d0604080834k7961aff5l7794b8893325a90c@mail.gmail.com>
	 <1144511112.2989.8.camel@laptopd505.fenrus.org>
	 <5a4c581d0604080927g532b6d10y7992d9adb4e63d08@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 08 Apr 2006 18:36:06 +0200
Message-Id: <1144514167.2989.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-08 at 18:27 +0200, Alessandro Suardi wrote:
> On 4/8/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > > Just for the record - no, even rebuilding same kernel with same GCC
> > >  (3.4.4) under FC5, disk performance is much slower than FC3 -
> > >  according to hdparm _and_ dd tests.
> >
> > what happens if you kill hald and other inotify using animals?
> 
> Thanks Arjan for looking into this.
> 
> Stopping hald brings hdparm from 18.5MB/s to 20MB/s, which is
>  indeed a noticeable improvement, though still far from the FC3
>  performance. I'm unsure what else can be stopped however
>  from this process list:
> 
>   274 ?        S<s    0:00 /sbin/udevd -d


try killing that one next; it may or may not help but it's sure worth a
try (esp given the success of the first kill :)


