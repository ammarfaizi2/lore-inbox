Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSKABiY>; Thu, 31 Oct 2002 20:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265331AbSKABiX>; Thu, 31 Oct 2002 20:38:23 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:18651 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265276AbSKABiX> convert rfc822-to-8bit; Thu, 31 Oct 2002 20:38:23 -0500
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrew Morton <akpm@digeo.com>, Hans Reiser <reiser@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Date: Fri, 1 Nov 2002 02:44:44 +0100
User-Agent: KMail/1.4.7
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Oleg Drokin <green@namesys.com>, zam@namesys.com,
       umka <umka@thebsh.namesys.com>
References: <3DC19F61.5040007@namesys.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com>
In-Reply-To: <3DC1D9D0.684326AC@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200211010244.44970.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 1. November 2002 02:33 schrieb Andrew Morton:
> Hans Reiser wrote:
> > Well, if we are only 2.5 times as fast for writes as ext3 after your
> > patch is applied, I'll still feel good.;-)
>
> whupping ext3's butt on write performance isn't very hard, really ;)
>
> But it should be done based on "feature equivalency".  By default,
> ext3 uses ordered data writes.  Data is written to disk before
> the metadata to which that data refers is committed to journal.
>
> It would be questionable to compare a metadata-only journalling
> approach to ext3 with data=journal or data=ordered.

As I understood it Reiser4 would have that from the beginning.
It is all new and not ReiserFS v3 which get this with Chris's data-logging 
patches delayed for 2.4.21/2.5.45+.

Plugins for encryption, ACLs, etc are in the works.

-Dieter
