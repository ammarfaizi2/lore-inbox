Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUH1CCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUH1CCD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 22:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUH1CCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 22:02:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44766 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266221AbUH1CBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 22:01:02 -0400
Date: Fri, 27 Aug 2004 21:59:58 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Spam <spam@tnonline.net>
cc: Jamie Lokier <jamie@shareable.org>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, <christophe@saout.de>,
       <vda@port.imtp.ilyichevsk.odessa.ua>, <christer@weinigel.se>,
       <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1798850364.20040828021903@tnonline.net>
Message-ID: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004, Spam wrote:

> > Whereas if you follow the OS's advice, and skip virtual files, then
> > backup and restore will recreate the filesystem, which is what you want.
> 
> > _That's_ storing everything.  It's what you want from a backup.
> 
>   It would be storing everything but the virtual files.

Thing is, there is no way to distinguish between what are
virtual files and what are actual streams hidden inside a
file.  You don't know what should and shouldn't be backed
up...

Hans says there must be a way, somehow, but I haven't seen
him tell this mailing list what exactly it is ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

