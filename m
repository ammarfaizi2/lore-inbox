Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262990AbTCWJuN>; Sun, 23 Mar 2003 04:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262991AbTCWJuN>; Sun, 23 Mar 2003 04:50:13 -0500
Received: from mail.ithnet.com ([217.64.64.8]:44818 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262990AbTCWJuM>;
	Sun, 23 Mar 2003 04:50:12 -0500
Date: Sun, 23 Mar 2003 11:00:52 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: jgarzik@pobox.com, szepe@pinerecords.com, arjanv@redhat.com,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-Id: <20030323110052.5267cba8.skraw@ithnet.com>
In-Reply-To: <20030321211708.GC12211@zaurus.ucw.cz>
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com>
	<1047923841.1600.3.camel@laptop.fenrus.com>
	<20030317182040.GA2145@louise.pinerecords.com>
	<20030317182709.GA27116@gtf.org>
	<20030321211708.GC12211@zaurus.ucw.cz>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003 22:17:08 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > Would it make sense to repackage 2.4.20 into something like 2.4.20-p1
> > > or 2.4.20.1 with only the critical stuff applied?
> > 
> > There shouldn't be a huge need to rush 2.4.21 as-is, really.  If you
> > want an immediate update, get the fix from your vendor.

Sorry Jeff,

this comment must obviously be flagged with a big community-buh. It is very
likely that most readers of LKML read/write here _not_ because they are
looking for a _vendor_ specific thing, but because they feel to a certain
extent as part of a linux-community and (partly) want to give something back
for the good things they got from it.
It is no hot news over here that linux does _not_ live because of 5 different
(or more?) "vendor"-kernels, but solely because there is _the_ official
kernel.org kernel (releases). 
For me personally I must say there is nothing I care less about than a
vendor-kernel - not because I think they are doing a bad job _in general_, but
because they are expected to be _less_ tested than "official" releases.
My favourite vendor (which I won't name here) managed to create a kernel that
does not even completely boot on about 8 of 10 of my test-beds. And guess what:
replacing the patched-to-death vendor kernel with kernel.org release makes all
of them work (at least boot correctly).

So IMHO: if there is a-known-to-work patch for the discussed exploit it should
be released as _some_ (pre-)release for 2.4 quickly, and thanks must go to alan
for taking quick approach on 2.2.

-- 
Regards,
Stephan

