Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWG3LyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWG3LyB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWG3LyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:54:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54996 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932265AbWG3LyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:54:00 -0400
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH 00/23] V4L/DVB fixes
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-dvb-maintainer@linuxtv.org,
       akpm@osdl.org, Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0607292352490.32415@shell2.speakeasy.net>
References: <20060725180311.PS54604900000@infradead.org>
	 <1154222716.27019.39.camel@praia>
	 <Pine.LNX.4.64.0607292300070.4168@g5.osdl.org>
	 <Pine.LNX.4.58.0607292352490.32415@shell2.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 30 Jul 2006 08:53:10 -0300
Message-Id: <1154260390.27019.45.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Em Dom, 2006-07-30 às 00:11 -0700, Trent Piepho escreveu:
> On Sat, 29 Jul 2006, Linus Torvalds wrote:
> > On Sat, 29 Jul 2006, Mauro Carvalho Chehab wrote:
> > >
> > > Please pull these (and the other ones) from master branch at:
> > >         kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
> >
> > I get a _huge_ diffstat with
> >
> >  135 files changed, 3056 insertions(+), 1562 deletions(-)
I suspect Linus tried to merge from branch "devel", instead of "master".
> 
> There are mostly two things which did this.
> 
> One is that Mauro translated almost all of the V4L1 radio card drivers to
> V4L2.  The changes are all very repetitive, but it made a huge diffstat:
> 
>  15 files changed, 1758 insertions(+), 918 deletions(-)
> 
> The second source is the dvb_attach() system, which was not supposed to go
> in 2.6.18, it was for 2.6.19.
> 
>  74 files changed, 827 insertions(+), 622 deletions(-)
> 
> The dvb_attach() stuff isn't ready for 2.6.18, it hasn't been tested at all
> and it's a very significant change.  The ISA radio card drivers....  I
> don't think they are used very much anymore.
No. The stuff to Linus is at branch "master" on my tree, with the bug
fixes. V4L1 conversion, dvb_attach and other neat stuff are on branch
"devel", and are meant to go to kernel 2.6.19 or upper.

Cheers, 
Mauro.

