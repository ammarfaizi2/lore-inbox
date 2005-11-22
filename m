Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVKVUhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVKVUhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVKVUhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:37:38 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:62237 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965168AbVKVUhh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:37:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QYRojV2hOijD3hFdUE6zfk3iyBgQ9DzEkpsX2GaU0yV9zqgfM7iJOQJITtBD/SMwGa4xdAvgVtahvtGENtenuFoHpu9+VUngzS5Rbd7yJgw8pH2fPYFBrk+61kIakdGUTXUVlHhv3/5OuaIQmaQ4k9uhC/nnCpPq+NPUXJRheCo=
Message-ID: <d120d5000511221237v51347b8fpe6292514e4eeca25@mail.gmail.com>
Date: Tue, 22 Nov 2005 15:37:36 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Cc: Bj?rn Mork <bmork@dod.no>, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000511221108h4ada6012kbf0b9d5166381904@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87zmoa0yv5.fsf@obelix.mork.no>
	 <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com>
	 <20051119234850.GC1952@spitz.ucw.cz>
	 <200511220026.55589.dtor_core@ameritech.net>
	 <871x19giuw.fsf@obelix.mork.no> <20051122174643.GB1752@elf.ucw.cz>
	 <d120d5000511221045x35cfb416q67c855414b896315@mail.gmail.com>
	 <20051122185900.GD1748@elf.ucw.cz>
	 <d120d5000511221108h4ada6012kbf0b9d5166381904@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 11/22/05, Pavel Machek <pavel@suse.cz> wrote:
> > Hi!
> >
> > > > > If a clueless users voice counts for anything: I couldn't agree more.
> > > > >
> > > > > A failed resume is a near catastrophy if you use and trust swsusp. And
> > > > > how could it ever be useful if you don't?
> > > >
> > > > Failed resume is only as bad as powerfail.
> > >
> > > So? I don't like powerfails either. Could you please answer this
> > > question - what pros of having resume process time out do you
> > > envision? What problems does it help to solve?
> >
> > No advantages, really.. except that it keeps suspend and resume paths
> > similar, and keeps the code simple. I'll want to call this from
> > userland and I'd hate to have two different calls or call with
> > parameter.
> >
>
> Passing a parameter from userspace - is it so hard? Oh well, if you
> prefer to leave this as a time bomb ready to explode - so be it.
>

I think my words were a tad too strong. I apologize.

--
Dmitry
