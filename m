Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUHZHfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUHZHfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 03:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUHZHfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 03:35:34 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:60165 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267720AbUHZHfc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 03:35:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 10:34:38 +0300
X-Mailer: KMail [version 1.4]
Cc: Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
References: <20040825152805.45a1ce64.akpm@osdl.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org>
In-Reply-To: <20040826053200.GU31237@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408261034.38509.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > A file is a stream of bytes.
> >
> > "OMG! It breaks tar and email!!!" argument doesn't fly. Things break all
> > the time and are fixed. It's called progress.
>
> What it breaks is the concept of a file. In ways that are ill-defined,
> not portable, hard to work with, and needlessly complex. Along the
> way, it breaks every single application that ever thought it knew what
> a file was.
>
> Progress? No, this has been done before. Various dead operating
> systems have done it or similar and regretted it. Most recently MacOS,
> which jumped through major hurdles to begin purging themselves of
> resource forks when they went to OS X. They're still there, but
> heavily deprecated.
>
> > cp, grep, cat, and tar will continue to work just fine on files with
> > multiple streams.
>
> Find some silly person with an iBook and open a shell on OS X. Use cp
> to copy a file with a resource fork. Oh look, the Finder has no idea
> what the new file is, even though it looks exactly identical in the
> shell. Isn't that _wonderful_? Now try cat < a > b on a file with a
> fork. How is that ever going to work?
>
> I like cat < a > b. You can keep your progress.

cat <a >b does not preserve following file properties even on standard
UNIX filesystems: name,owner,group,permissions.
-- 
vda
