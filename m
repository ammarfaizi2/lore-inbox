Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313547AbSDQJf6>; Wed, 17 Apr 2002 05:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313771AbSDQJf5>; Wed, 17 Apr 2002 05:35:57 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:24534 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S313547AbSDQJf4>; Wed, 17 Apr 2002 05:35:56 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "David S. Miller" <davem@redhat.com>, vojtech@suse.cz,
        rgooch@ras.ucalgary.ca, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Date: Wed, 17 Apr 2002 02:33:59 -0700 (PDT)
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <3CBD27F6.2070809@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0204170231090.389-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the byteswap feature to access these disks. It appears I was wrong
about the reason that I needed to use it, but the need is correct.

the fact is that for whatever reason the drives the tivo uses are
byteswapped compared to what they need to be for me to read them on an x86
system.

if another way is available I will use it, in the meantime I will not be
able to use 2.5 kernels to access those drives (since connecting and
disconnecting the drives requires a reboot this isn't a fatal flaw)

David Lang

On Wed, 17 Apr 2002, Martin Dalecki wrote:

> Date: Wed, 17 Apr 2002 09:44:54 +0200
> From: Martin Dalecki <dalecki@evision-ventures.com>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: David S. Miller <davem@redhat.com>, vojtech@suse.cz,
>      rgooch@ras.ucalgary.ca, torvalds@transmeta.com,
>      linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] 2.5.8 IDE 36
>
> David Lang wrote:
> > Ok, in that case it must be a wierd wiring of the IDE or something.
> >
> > I thought it was something more logical (silly me :-)
> >
> > David Lang
>
> Please do me a favour - next time don't proclaim using some feature which you
> actually don't. I know that the grammatical conjunktiv form is nearly dead in
> english - but please intersperese the next time words like "could" "may be"
> OK?
>
