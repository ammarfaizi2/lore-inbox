Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267977AbRG3VFr>; Mon, 30 Jul 2001 17:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbRG3VFh>; Mon, 30 Jul 2001 17:05:37 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:38149 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267977AbRG3VFR>; Mon, 30 Jul 2001 17:05:17 -0400
Message-ID: <3B65CC07.24E3EF4C@namesys.com>
Date: Tue, 31 Jul 2001 01:05:11 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: linux-kernel@vger.kernel.org, Vitaly Fertman <vitaly@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com> <20010730210644.A5488@caldera.de> <3B65C3D4.FF8EB12D@namesys.com> <20010730224930.A18311@caldera.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Christoph Hellwig wrote:
> 
> On Tue, Jul 31, 2001 at 12:30:12AM +0400, Hans Reiser wrote:
> > But there is not one where they recover from invalid arguments without a panic
> > (unless I failed to notice something),
> 
> Right.
> 
> > so it gets you nothing except a message
> > that we the developers will find more informative when trying to find what made
> > it crash.
> 
> Nope.  It does a reiserfs_panic instead of letting the wrong arguments
> slipping into lower layers and possibly on disk and thus corrupting data.
> 
> And in my opinion correct data is much more worth than one crash more or
> less (especially with a journaling filesystem).
> 
>         Christoph
> 
> --
> Whip me.  Beat me.  Make me maintain AIX.


There is nothing like a distro maintainer overriding the design decisions made
by the lead architect of a package, not believing that said architect knows what
the fuck he is doing.

We will make this unusable by you from this point onwards.  Vitaly, I told you
what to do weeks ago in this regard, do it today.

Does it get worse than shovelware?  I suppose it does....

Hans
