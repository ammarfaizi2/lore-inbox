Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSEVPKt>; Wed, 22 May 2002 11:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSEVPKs>; Wed, 22 May 2002 11:10:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32168 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315634AbSEVPKq>;
	Wed, 22 May 2002 11:10:46 -0400
Date: Wed, 22 May 2002 11:10:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "David S. Miller" <davem@redhat.com>, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AXyr-00020p-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0205221109240.2737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Alan Cox wrote:

> > ... and while we are at flamewar-mongering, none of these files have any
> > business being in procfs.
> 
> That depends on how you define procfs. Linux is not Plan 9. A lot of it 
> certainly is going to cleaner with a devicefs and sysctlfs

OK, let me put it that way:

none of these files has any business bringing the rest of procfs along
for a ride and none of them has any reason to use any code from fs/proc/*.c

