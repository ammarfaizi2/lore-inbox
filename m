Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282096AbRKWXUd>; Fri, 23 Nov 2001 18:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282282AbRKWXUY>; Fri, 23 Nov 2001 18:20:24 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:31781 "EHLO
	c0mailgw10.prontomail.com") by vger.kernel.org with ESMTP
	id <S282281AbRKWXUH>; Fri, 23 Nov 2001 18:20:07 -0500
Message-ID: <3BFED974.CAB4513C@starband.net>
Date: Fri, 23 Nov 2001 18:19:16 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Eldridge <diz@cafes.net>
CC: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Filesize limit on SMBFS
In-Reply-To: <Pine.LNX.4.42.0111231034330.15987-100000@boston.corp.fedex.com> <002801c1740f$7372f650$1300a8c0@marcelo> <20011123171157.Q21290@mail.cafes.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To put it simply, ext2 does not have a 2GB filesize limitation anymore, (in newer
distributions).

Mike Eldridge wrote:

> On Fri, Nov 23, 2001 at 09:10:24AM -0200, Marcelo Borges Ribeiro wrote:
> > I have fat32 partition, but the problem isn´t the size of partition it is
> > 8GB. The problem is that if you want to
> > create a cpio backup of a linux system 3.5GB (I did that to reformat a ext2
> > to a reiserfs) to an available fat32 space, in my case the backup size is
> > allways 2GB and when I tried to extract back I saw "unexpected end of file".
> > So I thought it was that famous kernel limitation of 2GB under any kind of
> > partition, but i was informed that fat has this limitation too. So the
> > kernel may suport files bigger than 2GB (I really don´t know, I just know
> > that in my case with fat32 it did not and I saw this too with some oracle
> > databases that could not be used when they grow and reach 2GB, may be a
> > library problem too).
>
> ext2 has a 2GB filesize limitation.
>
> -mike
>
> --------------------------------------------------------------------------
>    /~\  The ASCII                       all that is gold does not glitter
>    \ /  Ribbon Campaign                 not all those who wander are lost
>     X   Against HTML                          -- jrr tolkien
>    / \  Email!
>
>           radiusd+mysql: http://www.cafes.net/~diz/kiss-radiusd
> --------------------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

