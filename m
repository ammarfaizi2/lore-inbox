Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129205AbQKOVax>; Wed, 15 Nov 2000 16:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKOVam>; Wed, 15 Nov 2000 16:30:42 -0500
Received: from warp9.koschikode.com ([212.84.196.82]:55561 "HELO
	warp9.koschikode.com") by vger.kernel.org with SMTP
	id <S129170AbQKOVac>; Wed, 15 Nov 2000 16:30:32 -0500
Message-ID: <3A12F94D.B2ECDC2@koschikode.com>
Date: Wed, 15 Nov 2000 21:59:57 +0100
From: Juri Haberland <juri@koschikode.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Swapping over NFS in Linux 2.4?
In-Reply-To: <00111517064807.29351@bar> <Pine.LNX.4.21.0011151421580.5584-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 15 Nov 2000, Andreas Osterburg wrote:
> 
> > Because I set up a diskless Linux-workstation, I want to swap
> > over NFS. For this purpose I found only patches for "older"
> > Linux-versions (2.0, 2.1, 2.2?).
> 
> > Does anyone know wheter there are patches for 2.4 or does anyone
> > know another solution for this problem?
> 
> 1. you can swap over NBD
> 2. if you point me to the swap-over-nfs patches you
>    have found, I can try to make them work on 2.4 ;)
> 
> [I have some interest in making swap-over-nfs work and
> most of the other VM things in 2.4 are already pretty
> stable ... at the moment stability is more important
> than extra performance tricks to me]

There was a patch recently posted on the nfs mailing list by Tom Dyas
from VAlinux. It is against 2.2.17 with the nfs patches by Trond
Myklebust and Dave Higgen. The post (including the patch) can be found
here:  http://marc.theaimsgroup.com/?l=linux-nfs&m=97157102825580&w=2

Juri
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
