Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288951AbSATTZJ>; Sun, 20 Jan 2002 14:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288953AbSATTZA>; Sun, 20 Jan 2002 14:25:00 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:62364 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S288950AbSATTYu>;
	Sun, 20 Jan 2002 14:24:50 -0500
Date: Sun, 20 Jan 2002 14:24:40 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Andrew Morton <akpm@zip.com.au>,
        Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>,
        Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
In-Reply-To: <20020120193141.A1112@mea-ext.zmailer.org>
Message-ID: <Pine.SGI.4.31L.02.0201201422500.1767115-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Really?

Software raid?

I have a quad ppro that is doing ext3/md just fine, and its running
2.4.17.

On Sun, 20 Jan 2002, Matti Aarnio wrote:

> Date: Sun, 20 Jan 2002 19:31:41 +0200
> From: Matti Aarnio <matti.aarnio@zmailer.org>
> To: Andrew Morton <akpm@zip.com.au>
> Cc: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>,
>      Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>,
>      Linux-Kernel <linux-kernel@vger.kernel.org>, linux-raid@vger.kernel.org
> Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
>
> On Mon, Jan 07, 2002 at 02:09:29AM -0800, Andrew Morton wrote:
> ...
> > I spent *ages* on the ext3 buffer writeout code and it's still not
> > ideal.  Can you test with this patch applied?
> >
> > http://www.zipworld.com.au/~akpm/linux/2.4/2.4.18-pre1/mini-ll.patch
> >
> > It should go into 2.4.17 OK.
>
>    I just tried this into  2.4.18-pre4  and it still hard-hangs
>    the RAID-1 + EXT3 on SMP.
>
> /Matti Aarnio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

