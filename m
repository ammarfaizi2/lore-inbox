Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268003AbRG3VVT>; Mon, 30 Jul 2001 17:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268020AbRG3VVJ>; Mon, 30 Jul 2001 17:21:09 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:24070 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268003AbRG3VVC>; Mon, 30 Jul 2001 17:21:02 -0400
Message-ID: <3B65CFC5.A6B4FC08@namesys.com>
Date: Tue, 31 Jul 2001 01:21:09 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: linux-kernel@vger.kernel.org
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

The cost is not a crash, the cost is performance sucks.

> 
>         Christoph
> 
> --
> Whip me.  Beat me.  Make me maintain AIX.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Are you going to leave it on for future versions of ReiserFS, or just for Linux
2.4.2? 

Hans
