Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSKDSEG>; Mon, 4 Nov 2002 13:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSKDSEG>; Mon, 4 Nov 2002 13:04:06 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:6661 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262420AbSKDSEF>; Mon, 4 Nov 2002 13:04:05 -0500
Date: Mon, 4 Nov 2002 19:10:36 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Alexander Zarochentcev <zam@Namesys.COM>, Hans Reiser <reiser@Namesys.COM>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@Namesys.COM>,
       umka <umka@Namesys.COM>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Message-ID: <20021104181036.GE8606@louise.pinerecords.com>
References: <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com> <3DC1DF02.7060307@namesys.com> <20021101102327.GA26306@louise.pinerecords.com> <15810.46998.714820.519167@crimson.namesys.com> <20021102133824.GL28803@louise.pinerecords.com> <15814.25070.118410.47102@laputa.namesys.com> <20021104171055.GD8606@louise.pinerecords.com> <15814.46090.7694.593433@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15814.46090.7694.593433@laputa.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Worse though, at one point I stumbled upon the following:
>  > 
>  > $ df /ap
>  > Filesystem           1k-blocks      Used Available Use% Mounted on
>  > /dev/sda2              1490332 -73786976294838198272   1498808 101% /ap
>  > 
>  > This was right after I hit the reset button while compiling the kernel
>  > off a reiser4 mountpoint, went on to finish the build after reboot and
>  > then "rm -rf"'d the whole source tree (i.e. there was nothing on the
>  > filesystem again).
>  > 
>  > reiser4.o is 20021031 plus the rmdir leak fix from this thread plus
>  > your patch above.
> 
> Do you have debugging on?

Nop.

-- 
tomas szepe <szepe@pinerecords.com>
