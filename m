Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262014AbSI3K6R>; Mon, 30 Sep 2002 06:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262016AbSI3K6R>; Mon, 30 Sep 2002 06:58:17 -0400
Received: from c0202001.roe.itnq.net ([217.112.132.110]:4480 "EHLO
	thinkpad.objectsecurity.cz") by vger.kernel.org with ESMTP
	id <S262014AbSI3K6Q>; Mon, 30 Sep 2002 06:58:16 -0400
Date: Mon, 30 Sep 2002 13:03:19 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.objectsecurity.cz
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] apm resume hangs on IBM T22 with 2.4.19 (harddrive sleeps
 forever)
In-Reply-To: <20020925225230.0028639b.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.43.0209301300200.462-100000@thinkpad.objectsecurity.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Stephen Rothwell wrote:

> On Wed, 25 Sep 2002 12:58:11 +0200 (CEST) Karel Gardas <kgardas@objectsecurity.com> wrote:
> >
> > I have problem with resume from suspend on IBM T22 with kernel 2.4.19
> > patched with rmap-14a and usagi-20020916. Actually the problem is that OS
> > resume well from suspend (it prints some messages to console for example
> > from FW droping some packets), but harddisc is still sleeping and never
> > wake up...
>
> I have a T22 and run 2.4.20-pre5 and 2.4.19-pre8 with no patches and
> have no problems resuming from suspend.

But you don't have clean 2.4.19.

[...]

> All I can suggest is that you try 2.4.19 without any patches, then with
> the rmap patch and then with only the USAGI patch and see if that makes
> any difference.

I've done it right now and it seems 2.4.19 w/o any patch is broken for me.
i.e. it behaves the same wrong way and hd is sleeping forevere after apm
resume...

Anything what should I test now?

Thanks a lot,

Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com

