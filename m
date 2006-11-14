Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933188AbWKNDpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933188AbWKNDpi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 22:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933239AbWKNDpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 22:45:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:25188 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933199AbWKNDpg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 22:45:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aLz1iMU+EgFnZlmi5kFa2tSOIeFe5/u85SY45UFXCj6MgOBNYjrTsXvx0WhpupqxmRr9036yU3GutZIODBfxgk7F/TQPx07QS5hlSyZVlgJ6MbKRHS5tlGtp9G+zRwqxePMzgC1jLL/md6l5Fu1MjAOeSV1cfBIkAZ8dJbRLvL4=
From: =?iso-8859-1?q?Jos=E9_Su=E1rez?= <j.suarez.agapito@gmail.com>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [linux-dvb] Avermedia 777 misbehaves after remote hack merged into v4l-dvb tree
Date: Tue, 14 Nov 2006 04:45:29 +0100
User-Agent: KMail/1.9.5
Cc: Michael Krufky <mkrufky@linuxtv.org>, "pasky@ucw.cz" <pasky@ucw.cz>,
       Linus Torvalds <torvalds@osdl.org>, linux-dvb@linuxtv.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
References: <200611131711.46626.j.suarez.agapito@gmail.com> <4558DF23.5080207@linuxtv.org> <1163453015.26319.29.camel@201-2-70-92.bsace705.w.brasiltelecom.net.br>
In-Reply-To: <1163453015.26319.29.camel@201-2-70-92.bsace705.w.brasiltelecom.net.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611140445.30269.j.suarez.agapito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Lunes 13 Noviembre 2006 22:23, Mauro Carvalho Chehab escribió:
> Em Seg, 2006-11-13 às 16:09 -0500, Michael Krufky escreveu:
> > Linus Torvalds wrote:
> > > On Mon, 13 Nov 2006, Michael Krufky wrote:
> > >> Mauro -- that patch needs fixing / more testing before it goes to
> > >> mainstream...
> > >>
> > >> Could you please remove that changeset from your git tree before Linus
> > >> pulls it?
> > >
> > > Too late. Already pulled and pushed out.
> > >
> > > Looking at the patch, one obvious bug stands out: the new case
> > > statement for SAA7134_BOARD_AVERMEDIA_777 doesn't have a "break" at the
> > > end.
> > >
> > > José, can you test this trivial patch and see if it fixes things?
>
> Yes, this should fix the issue. It passed by my eyes :(
>
> > Mauro, please pull from:
> >
> > http://linuxtv.org/hg/~mkrufky/v4l-dvb
> >
> > for the following:
> >
> > - saa7134: Fix missing 'break' for avermedia card case
>
> Ok, I've updated also master development tree at
> http://linuxtv.org/hg/v4l-dvb
>
> Pasky,
>
> Please test it also.
>
> Cheers,
> Mauro.

The Avermedia 777 is working perfectly again with the current v4l-dvb tree. No 
more misbehaviours. Looks like you guys addressed and resolved the issue 
quite fast :)
At the moment I can't give the remote control a try because lirc doesn't 
compile against version 2.6.18 of the kernel. If that lirc issue gets solved, 
I will try to use it as soon as I can.

All the best.
