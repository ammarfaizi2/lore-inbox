Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSKEUKO>; Tue, 5 Nov 2002 15:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbSKEUKO>; Tue, 5 Nov 2002 15:10:14 -0500
Received: from stinky.trash.net ([195.134.144.50]:9889 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id <S265187AbSKEUKN>;
	Tue, 5 Nov 2002 15:10:13 -0500
Date: Tue, 5 Nov 2002 21:16:47 +0100 (MET)
From: "Peter H. Ruegg" <lin.kernel@incense.org>
X-X-Sender: peach@stinky.trash.net
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
In-Reply-To: <20021105181431.GB3515@suse.de>
Message-ID: <Pine.GSO.4.42.0211052114170.11701-100000@stinky.trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll write the script, just a damn shame that this feature is gone now.
> .config editing is less powerful now.

Well, the script is easy...

cat << DONE >> .vimrc
:map - :s/=y$/ is not set/:s/^/# /
DONE

Needs even less work than before now...

--8<-------------------------------------------------------------------------
main(){char*s="O_>>^PQAHBbPQAHBbPOOH^^PAAHBJPAAHBbPA_H>BB";int i,j,k=1,l,m,n;
for(j=0;j<7;j++)for(l=0;m=l-6+j,i=m/6,n=j*6+i,k=1<<m%6,l<41-j;l++)
putchar(l<6-j?' ':l==40-j?'\n':k&&s[n]&k?'*':' ');}

