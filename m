Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSEXQFr>; Fri, 24 May 2002 12:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSEXQDQ>; Fri, 24 May 2002 12:03:16 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:34553 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317181AbSEXQCj>; Fri, 24 May 2002 12:02:39 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E17BHha-0006m7-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dalecki@evision-ventures.com (Martin Dalecki), jack@suse.cz (Jan Kara),
        nathans@sgi.com (Nathan Scott),
        torvalds@transmeta.com (Linus Torvalds),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 May 2002 17:01:09 +0100
Message-ID: <32201.1022256069@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Uninline copy*user and a few other things then. Fix the size of
> struct page. Add a CONFIG_SMALL where users can pick to have very
> small hash tables on older systems with little RAM.  Add the two extra
> common slab sizes  people identified

Don't forget CONFIG_BLK_DEV

--
dwmw2


