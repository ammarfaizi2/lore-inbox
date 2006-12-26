Return-Path: <linux-kernel-owner+w=401wt.eu-S932732AbWLZRZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbWLZRZ1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 12:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbWLZRZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 12:25:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:23023 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732AbWLZRZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 12:25:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TELBN8VImfecHT3OdgKsWEAig5YGzyRq0NkW2UrpaIooofuYoIpFqzFYEBj6jPk3iNavxSJAX6HRwK/HWtW7JxZS/ZGbaztEmL4EttM0GtQZkJUANUBynbPdzqmyjrb/us8sr4yZQU/OL0TICmrj70HnrWlFd4Q7+aU8NrjZh24=
Message-ID: <b637ec0b0612260925x9c40e5akbb009e15d15c58d0@mail.gmail.com>
Date: Tue, 26 Dec 2006 12:25:24 -0500
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: BUG: scheduling while atomic - Linux 2.6.20-rc2-ga3d89517
Cc: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <20061226171531.GC7600@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b637ec0b0612240553n28b252c4p4c1559da794e646c@mail.gmail.com>
	 <87psa9z0wu.fsf@duaron.myhome.or.jp>
	 <b637ec0b0612251102w2bb4a4c1ifc78df1193879c6f@mail.gmail.com>
	 <20061226171531.GC7600@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 12/26/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > some days and will let you know if the problem represents. Please note
> > that it happened only twice and I don't have any clue on how to
> > reproduce it.
> >
> > I added Pavel and Rafael to CC-list because for the first time in at
> > least six months my laptop failed to resume after suspend-to-disk
> > (userland tools) with this kernel. Guys, do you think that this
> > failure could be related to this BUG?
>
> everything is possible, but this one does not seem too likely. Is
> failure reproducible?
>

Not at all. I applied Hirofumi's patch and the problem seems to be
gone. But it was impossible to reproduce even without it: the BUG
happened only twice and the resume failure only once.


>                                                                 Pavel

Fabio
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
